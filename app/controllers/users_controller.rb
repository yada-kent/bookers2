class UsersController < ApplicationController
  before_action :ensure_user, only: [:edit, :update,]

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def index
    @users = User.all
    @book = Book.new
    @user = current_user
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    if @user.save
      redirect_to user_path(@user.id)
      flash[:notice]="You have updated user successfully."
    else
      render :edit
    end
  end




  def destroy
  end

  private

  def ensure_user
    @user = User.find(params[:id])
      unless @user == current_user
        redirect_to users_path
      end
  end


  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction,)
  end

end
