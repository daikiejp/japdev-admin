class DevsheetSectionsController < ApplicationController
  before_action :set_category_and_topic
  before_action :set_section, only: %i[ show edit update destroy ]

  def index
    redirect_to devsheet_category_devsheet_topic_path(@category, @topic)
  end

  def show
  end

  def new
    @section = @topic.devsheet_sections.new
    @section.devsheet_code_blocks.build
  end

  def edit
  end

  def create
    @section = @topic.devsheet_sections.new(section_params)

    if @section.save
      redirect_to devsheet_category_devsheet_topic_path(@category, @topic),
                  notice: "セクション「#{@section.title}」が正常に作成されました。"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @section.update(section_params)
      redirect_to devsheet_category_devsheet_topic_path(@category, @topic),
                  notice: "セクション「#{@section.title}」が正常に更新されました。"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    title = @section.title
    @section.destroy
    redirect_to devsheet_category_devsheet_topic_path(@category, @topic),
                notice: "セクション「#{title}」が正常に削除されました。"
  end

  # JSONエクスポート（fundamentals.json, flexbox.json形式）
  def export_section_json
    sections_data = @topic.devsheet_sections.map(&:to_export_hash)
    send_data JSON.pretty_generate(sections_data),

              filename: "#{@topic.name.downcase.gsub(' ', '-')}.json",
              type: "application/json",
              disposition: "attachment"
  end

  private
    def set_category_and_topic
      @category = DevsheetCategory.find(params[:devsheet_category_id])
      @topic = @category.devsheet_topics.find(params[:devsheet_topic_id])
    end

    def set_section
      @section = @topic.devsheet_sections.find(params[:id])
    end

    def section_params
      params.require(:devsheet_section).permit(
        :title,
        :slug,
        :description,
        devsheet_code_blocks_attributes: [
          :id,
          :title,
          :language,
          :filename,
          :code,
          :highlight_lines,
          :_destroy,
          devsheet_code_block_tabs_attributes: [
            :id,
            :label,
            :code,
            :language,
            :title,
            :position,
            :_destroy
          ]
        ]
      )
    end
end
