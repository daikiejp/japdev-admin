class DevsheetCodeBlocksController < ApplicationController
  before_action :set_section
  before_action :set_code_block, only: %i[ edit update destroy ]

  def new
    @code_block = @section.devsheet_code_blocks.new
  end

  def edit
  end

  def create
    @code_block = @section.devsheet_code_blocks.new(code_block_params)

    if @code_block.save
      redirect_to devsheet_category_devsheet_topic_path(@section.devsheet_topic.devsheet_category, @section.devsheet_topic),
                  notice: "コードブロックが正常に追加されました。"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @code_block.update(code_block_params)
      redirect_to devsheet_category_devsheet_topic_path(@section.devsheet_topic.devsheet_category, @section.devsheet_topic),
                  notice: "コードブロックが正常に更新されました。"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @code_block.destroy
    redirect_to devsheet_category_devsheet_topic_path(@section.devsheet_topic.devsheet_category, @section.devsheet_topic),
                notice: "コードブロックが正常に削除されました。"
  end

  private
    def set_section
      @section = DevsheetSection.find(params[:devsheet_section_id])
    end

    def set_code_block
      @code_block = @section.devsheet_code_blocks.find(params[:id])
    end

    def code_block_params
      params.require(:devsheet_code_block).permit(:title, :language, :filename, :code, :highlight_lines, devsheet_code_block_tabs_attributes: [
      :id,
      :label,
      :code,
      :language,
      :title,
      :position,
      :_destroy
    ])
    end
end
