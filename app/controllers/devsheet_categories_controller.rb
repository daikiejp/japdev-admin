class DevsheetCategoriesController < ApplicationController
  before_action :set_category, only: %i[ show edit update destroy export_json ]

  def index
    @categories = DevsheetCategory.includes(:devsheet_topics).order(:id)
  end

  def show
    @topics = @category.devsheet_topics.includes(:devsheet_sections).order(:id)
  end

  def new
    @category = DevsheetCategory.new
  end

  def edit
  end

  def create
    @category = DevsheetCategory.new(category_params)

    if @category.save
      redirect_to devsheet_categories_path, notice: "カテゴリ「#{@category.name}」が正常に作成されました。"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @category.update(category_params)
      redirect_to devsheet_categories_path, notice: "カテゴリ「#{@category.name}」が正常に更新されました。"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    name = @category.name
    @category.destroy
    redirect_to devsheet_categories_path, notice: "カテゴリ「#{name}」が正常に削除されました。"
  end

  # JSONエクスポート（index.json形式）
  def export_json
    data = {
      id: @category.slug,
      name: @category.name,
      logo: @category.logo,
      description: @category.description,
      color: @category.color,
      topicsCount: @category.topics_count
    }

    # send_data JSON.pretty_generate(data),
    send_data JSON.pretty_generate(data),
              filename: "#{@category.name.downcase}-category.json",
              type: "application/json",
              disposition: "attachment"
  end

  # 全カテゴリをまとめてJSONエクスポート
  def export_all_json
    categories_data = DevsheetCategory.order(:id).map(&:to_export_hash)

    send_data JSON.pretty_generate(categories_data),
              filename: "categories.json",
              type: "application/json",
              disposition: "attachment"
  end

  private
    def set_category
      @category = DevsheetCategory.find(params[:id])
    end

    def category_params
      params.require(:devsheet_category).permit(:name, :slug, :logo, :description, :color)
    end
end
