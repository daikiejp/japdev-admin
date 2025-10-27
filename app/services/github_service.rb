class GithubService
  include HTTParty
  base_uri "https://api.github.com"

  def initialize
    @options = {
      headers: {
        "Accept" => "application/vnd.github.v3+json",
        "User-Agent" => "JapDev-Admin-App"
      }
    }

    # GitHub Personal Access Tokenがある場合は設定
    if ENV["GITHUB_TOKEN"].present?
      @options[:headers]["Authorization"] = "token #{ENV['GITHUB_TOKEN']}"
    end
  end

  def fetch_latest_release(repo_path)
    response = self.class.get("/repos/#{repo_path}/releases/latest", @options)

    repo_response = self.class.get("/repos/#{repo_path}", @options)

    # リリースがない場合はタグから取得を試みる
    if response.code == 404
      return fetch_latest_tag(repo_path)
    end

    return nil unless response.success?

    {
      version: response["tag_name"].to_s.gsub(/^v/, ""),
      date: Date.parse(response["published_at"]),
      description: response["name"] || response["body"]&.split("\n")&.first&.truncate(200),
      changelog_url: response["html_url"],
      stars: repo_response.success? ? repo_response["stargazers_count"] : nil,
      repo_description: repo_response.success? ? repo_response["description"] : nil
    }
  rescue StandardError => e
    Rails.logger.error "GitHub API エラー: #{e.message}"
    nil
  end

  private

  def fetch_latest_tag(repo_path)
    response = self.class.get("/repos/#{repo_path}/tags", @options)

    return nil unless response.success? && response.any?

    latest_tag = response.first

    unless repo_response&.success?
      repo_response = self.class.get("/repos/#{repo_path}", @options)
    end

    {
      version: latest_tag["name"].to_s.gsub(/^v/, ""),
      date: Date.today,
      description: "最新タグ: #{latest_tag['name']}",
      changelog_url: "https://github.com/#{repo_path}/releases",
      stars: repo_response.success? ? repo_response["stargazers_count"] : nil,
      repo_description: repo_response.success? ? repo_response["description"] : nil
    }
  rescue StandardError => e
    Rails.logger.error "GitHub API エラー (tags): #{e.message}"
    nil
  end
end
