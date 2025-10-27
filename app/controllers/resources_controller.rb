class ResourcesController < ApplicationController
  before_action :set_resource, only: %i[ show edit update destroy ]

  def index
    @resources = Resource.order(:title) # (:category, :title)
  end

  def show
  end

  def new
    @resource = Resource.new
  end

  def edit
  end

  def create
    @resource = Resource.new(resource_params)

    if @resource.save
      redirect_to resources_url, notice: "リソースが正常に作成されました。"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @resource.update(resource_params)
      redirect_to resources_url, notice: "リソースが正常に更新されました。"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @resource.destroy
    redirect_to resources_url, notice: "リソースが正常に削除されました。"
  end

  # JSONファイル生成
  def export_json
    resources = Resource.order(:category, :title).map do |resource|
      {
        title: resource.title,
        desc: resource.desc,
        category: resource.category,
        url: resource.url
      }
    end

    send_data JSON.pretty_generate(resources),
              filename: "resources.json",
              type: "application/json"
  end

  private
    def set_resource
      @resource = Resource.find(params[:id])
    end

    def resource_params
      params.require(:resource).permit(:title, :desc, :category, :url)
    end
end
