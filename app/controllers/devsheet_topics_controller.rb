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
    topics_data = @category.devsheet_topics.order(:created_at).map(&:to_export_hash)

    send_data JSON.pretty_generate(topics_data),
              filename: "#{@category.name.downcase}-topics.json",
              type: "application/json",
              disposition: "attachment"
  end

  # 全トピックをまとめてJSONエクスポート
  def export_all_topics_json
    topics_data = @category.devsheet_topics.order(:created_at).map(&:to_export_hash)

    send_data JSON.pretty_generate(topics_data),
              filename: "#{@category.name.downcase}-topics.json",
              type: "application/json",
              disposition: "attachment"
  end

  def import_form
    @topic = @category.devsheet_topics.find(params[:topic_id])
  end

  def import_sections
    @topic = @category.devsheet_topics.find(params[:topic_id])

    unless params[:json_file].present?
      redirect_to devsheet_category_devsheet_topic_path(@category, @topic),
                  alert: "JSONファイルを選択してください。"
      return
    end

    begin
      file_content = params[:json_file].read
      sections_data = JSON.parse(file_content)

      # Validar que sea un array
      unless sections_data.is_a?(Array)
        raise "JSONファイルはセクションの配列である必要があります。"
      end

      imported_count = 0
      errors = []

      ActiveRecord::Base.transaction do
        sections_data.each_with_index do |section_data, index|
          begin
            import_section(section_data)
            imported_count += 1
          rescue => e
            errors << "セクション #{index + 1}: #{e.message}"
          end
        end

        if errors.any?
          raise ActiveRecord::Rollback
        end
      end

      if errors.empty?
        redirect_to devsheet_category_devsheet_topic_path(@category, @topic),
                    notice: "#{imported_count}個のセクションが正常にインポートされました。"
      else
        flash[:alert] = "インポート中にエラーが発生しました:\n#{errors.join("\n")}"
        render :import_form, status: :unprocessable_entity
      end

    rescue JSON::ParserError
      redirect_to devsheet_category_devsheet_topic_path(@category, @topic),
                  alert: "無効なJSONファイルです。"
    rescue => e
      redirect_to devsheet_category_devsheet_topic_path(@category, @topic),
                  alert: "インポートエラー: #{e.message}"
    end
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

  def import_section(section_data)
    section = @topic.devsheet_sections.find_or_initialize_by(
      slug: section_data["id"]
    )

    section.assign_attributes(
      title: section_data["title"],
      description: section_data["description"]
    )

    section.save!

    if section_data["codeBlocks"].present?
      section_data["codeBlocks"].each do |block_data|
        import_code_block(section, block_data)
      end
    end
  end

  def import_code_block(section, block_data)
     has_tabs = block_data["tabs"].present?

    code_value = has_tabs ? "TEMP_PLACEHOLDER" : (block_data["code"].presence || "")

    code_block = section.devsheet_code_blocks.create!(
      title: block_data["title"],
      language: block_data["language"] || "plaintext",
      filename: block_data["filename"],
      code: code_value,
      highlight_lines: block_data["highlightLines"] || []
    )

    if has_tabs
      block_data["tabs"].each_with_index do |tab_data, index|
        code_block.devsheet_code_block_tabs.create!(
          label: tab_data["label"],
          code: tab_data["code"],
          language: tab_data["language"],
          title: tab_data["title"],
          position: index + 1
        )
      end

      code_block.update_column(:code, "")
    end
  end
end
