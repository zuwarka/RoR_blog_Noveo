class ArticlesController < ApplicationController
  before_action :set_article, only: %i[edit update show destroy]
  after_action :write_to_log

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    @article.user = User.find(session[:user_id]) unless session[:user_id].nil?
    if @article.save
      flash[:success] = "Article was successfully created"
      redirect_to article_path(@article)
    else
      render 'new'
    end
  end

  def show
    @article = Article.find_by(id: params[:id].to_i)
    respond_to do |format|
      format.html
      format.pdf{
        render pdf: "article #{params[:id]}", template: 'articles/show', formats: [:html]
      }
    end
  end

  def update
    if @article.update(article_params)
      flash[:success] = "Article was updated"
      redirect_to article_path(@article)
    else
      flash[:success] = "Article was not updated"
      render 'edit'
    end
  end

  def edit
  end

  def index
    @articles = Article.title_or_description_like(params[:search]).paginate(page: params[:page], per_page: 5)

    respond_to do |format|
      format.html
      format.pdf{
        render pdf: "articles", template: 'articles/index', formats: [:html]
      }
    end
  end

  def destroy
    @article.destroy
    flash[:success] = "Article was deleted"
    redirect_to articles_path
  end

  private

  def article_params
    params.require(:article).permit(:title, :description)
  end

  def set_article
    @article = Article.find(params[:id])
  end
  # logging with log model
  def write_to_log
    Log.create(
      remote_ip: request.remote_ip,
      request_method: request.method,
      request_url: request.url,
      response_status: response.status,
      response_content_type: response.content_type
    )
  end

end