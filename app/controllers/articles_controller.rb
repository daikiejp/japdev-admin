class ArticlesController < ApplicationController
  before_action :set_article, only: %i[ show edit update destroy ]

  def index
    @articles = Article.order(date: :desc)
  end

  def show
  end

  def new
    @article = Article.new
  end

  def edit
  end

  def create
    @article = Article.new(article_params)

    if @article.save
      redirect_to article_url, notice: "記事が正常に作成されました。"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @article.update(article_params)
      redirect_to articles_url, notice: "記事が正常に更新されました。"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @article.destroy
    redirect_to articles_url, notice: "記事が正常に削除されました。"
  end

  # JSONファイル生成
  def export_json
    articles = Article.order(date: :desc).map do |article|
      {
        title: article.title,
        source: article.source,
        url: article.url,
        date: article.date&.strftime("%Y-%m-%d"),
        tags: article.tags,
        image: article.image,
        description: article.description,
        author: article.author
      }
    end

    send_data JSON.pretty_generate(articles),
              filename: "articles.json",
              type: "application/json"
  end

  private
    def set_article
      @article = Article.find(params[:id])
    end

    def article_params
      params.require(:article).permit(:title, :source, :url, :date, :image, :description, :author, :tags)
    end
end
