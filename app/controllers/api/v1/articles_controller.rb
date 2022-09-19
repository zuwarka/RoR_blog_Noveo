class Api::V1::ArticlesController < ApplicationController
  before_action :set_article, only: %i[edit update show destroy]
  after_action :write_to_log
  #before_action :authenticate_user!

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    # @article.user = User.first
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
      format.xml{
        render show: @article
      }
      format.json{
        render show: @article
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
    @articles = Article.paginate(page: params[:page], per_page: 5)
    respond_to do |format|
      format.xml{
        render index: @articles
      }
      format.json{
        render index: @articles
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
    log = Log.create(
      remote_ip: request.remote_ip,
      request_method: request.method,
      request_url: request.url
    )
    log.response_status = response.status
    log.response_content_type = response.content_type
    log.save
  end
end
