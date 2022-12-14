class UsersController < ApplicationController
  #before_action :authenticate_user!
  #protect_from_forgery prepend: true

  def index
    @users = User.order(created_at: 'asc').paginate(page: params[:page], per_page: 3)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      if @user.authenticate(user_params[:password])
        session[:user_id] = @user.id
        flash[:success] = "Welcome to the alpha blog!"
        redirect_to users_path(@user)
      else
        flash[:success] = "Welcome to the alpha blog #{@user.username}"
        redirect_to articles_path
      end
    else
      render 'new'
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = "Your account was updated successfully"
      redirect_to articles_path
    else
      render 'edit'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def show
    @user = User.find(params[:id])
    @user_articles = @user.articles.paginate(page: params[:page], per_page: 5)
  end

  private
  def user_params
    params.require(:user).permit(:username, :email, :password)
  end
end
