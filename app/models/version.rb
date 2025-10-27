class Version < ApplicationRecord
  validates :name, presence: true
  validates :repo_url, presence: true, format: { with: /\Ahttps:\/\/github\.com\/[^\/]+\/[^\/]+/i, message: "は有効なGitHubリポジトリURLである必要があります" }

  STATUSES = {
    "new" => "新規",
    "stable" => "安定版",
    "lts" => "長期サポート"
  }.freeze

  # GitHub APIから情報を取得
  def fetch_from_github
    return unless repo_url.present?

    repo_path = extract_repo_path(repo_url)
    return unless repo_path

    service = GithubService.new
    data = service.fetch_latest_release(repo_path)

    if data
      self.version = data[:version]
      self.date = data[:date]
      self.description = data[:description] # if description.blank?
      self.changelog_url = data[:changelog_url] # if changelog_url.blank?
      self.stars = data[:stars]
      self.repo_description = data[:repo_description]
      self.status = "new" # if status.blank?
    end
  end

  private

  def extract_repo_path(url)
    # https://github.com/facebook/react -> facebook/react
    match = url.match(/github\.com\/([^\/]+\/[^\/]+)/i)
    match[1].gsub(/\.git$/, "") if match
  end
end
