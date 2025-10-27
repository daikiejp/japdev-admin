class VersionsController < ApplicationController
  before_action :set_version, only: %i[ show edit update destroy fetch_github ]

  def index
    @versions = Version.order(stars: :desc)
  end

  def show
  end

  def new
    @version = Version.new
  end

  def edit
  end

  def create
    @version = Version.new(version_params)

    # GitHub APIから情報を取得
    @version.fetch_from_github if @version.repo_url.present?

    if @version.save
      redirect_to versions_url, notice: "バージョンが正常に作成されました。"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @version.update(version_params)
      redirect_to versions_url, notice: "バージョンが正常に更新されました。"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @version.destroy
    redirect_to versions_url, notice: "バージョンが正常に削除されました。"
  end

  # GitHub APIから最新情報を取得
  def fetch_github
    @version.fetch_from_github
    if @version.save
      redirect_to versions_url notice: "GitHub APIから情報を更新しました。"
    else
      redirect_to versions_url, alert: "GitHub APIからの取得に失敗しました。"
    end
  end

  # 全てのバージョンをGitHubから更新
  def fetch_all_github
    updated_versions = []
    failed_versions = []

    Version.find_each do |version|
      old_version = version.version
      version.fetch_from_github

      if version.save
        if old_version != version.version
          updated_versions << "#{version.name} (v#{old_version} → v#{version.version})"
        else
          updated_versions << version.name
        end
      else
        failed_versions << version.name
      end
    end

    if failed_versions.empty?
      redirect_to versions_path, notice: "全#{updated_versions.size}件のバージョン情報をGitHub APIから更新しました。"
    else
      redirect_to versions_path, alert: "#{updated_versions.size}件更新成功、#{failed_versions.size}件失敗: #{failed_versions.join(', ')}"
    end
  end

  # JSONファイル生成
  def export_json
    versions = Version.order(stars: :desc).map do |version|
      {
        name: version.name,
        version: version.version,
        date: version.date&.strftime("%Y-%m-%d"),
        description: version.description,
        status: version.status,
        stars: version.stars,
        repoUrl: version.repo_url,
        changelogUrl: version.changelog_url
      }
    end

    send_data JSON.pretty_generate(versions),
              filename: "versions.json",
              type: "application/json",
              disposition: "attachment"
  end

  private
    def set_version
      @version = Version.find(params[:id])
    end

    def version_params
      params.require(:version).permit(:name, :version, :date, :description, :repo_description, :stars, :status, :repo_url, :changelog_url)
    end
end
