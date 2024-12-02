class ArticlesController < ApplicationController
  before_action :authenticate_user!, only: [ :new, :create, :edit, :update, :destroy ]
  before_action :set_article, only: [ :show, :edit, :update, :destroy ]
  before_action :authorize_admin!, only: [ :destroy ]

  def index
    @articles = Article.all
  end

  def show
  end

  def new
    @article = current_user.articles.build
  end

  def create
    @article = current_user.articles.build(article_params)
    if @article.save
      redirect_to @article, notice: "Article created successfully."
    else
      render :new
    end
  end

  def edit
    unless current_user == @article.user || current_user.admin?
      redirect_to articles_path, alert: "You are not authorized to edit this article."
    end
  end

  def update
    if current_user == @article.user || current_user.admin?
      if @article.update(article_params)
        redirect_to @article, notice: "Article updated successfully."
      else
        render :edit
      end
    else
      redirect_to articles_path, alert: "You are not authorized to update this article."
    end
  end

  def destroy
    @article.destroy
    redirect_to articles_path, notice: "Article deleted successfully."
  end

  private

  def set_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :content)
  end

  def authorize_admin!
    unless current_user.admin?
      redirect_to articles_path, alert: "Only admins can delete articles."
    end
  end
end
