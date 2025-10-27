class DevsheetTopicsController < ApplicationController
  before_action :set_category
   before_action :set_topic, only: %i[ show edit update destroy export_json ]

  def index
    redirect_to devsheet_category_path(@category)
  end

  def show
    @sections = @topic.devsheet_sections.includes(:devsheet_code_blocks).order(:created_at)
  end

  def new
    @topic = @category.devsheet_topics.new
  end

  def edit
  end

  def create
    @topic = @category.devsheet_topics.new(topic_params)

    if @topic.save
      redirect_to devsheet_category_path(@category), notice: "トピック「#{@topic.name}」が正常に作成されました。"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @topic.update(topic_params)
      redirect_to devsheet_category_path(@category), notice: "トピック「#{@topic.name}」が正常に更新されました。"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    name = @topic.name
    @topic.destroy
    redirect_to devsheet_category_path(@category), notice: "トピック「#{name}」が正常に削除されました。"
  end

  # JSONエクスポート（topics.json形式）
  def export_json
    topics_data = @category.devsheet_topics.order(:created_at).map(&:to_export_hash).order(:created_at)

    send_data JSON.pretty_generate(topics_data),
              filename: "#{@category.name.downcase}-topics.json",
              type: "application/json",
              disposition: "attachment"
  end

  # 全トピックをまとめてJSONエクスポート
  def export_all_topics_json
    topics_data = @category.devsheet_topics.order(:created_at).map(&:to_export_hash)

    send_data JSON.pretty_generate(topics_data),
              filename: "#{@category.name.downcase}-all-topics.json",
              type: "application/json",
              disposition: "attachment"
  end

  private
    def set_category
      @category = DevsheetCategory.find(params[:devsheet_category_id])
    end

    def set_topic
      @topic = @category.devsheet_topics.find(params[:id])
    end

    def topic_params
      params.require(:devsheet_topic).permit(:name, :slug, :description)
    end
end
