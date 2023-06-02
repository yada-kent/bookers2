class BooksController < ApplicationController

  before_action :ensure_user, only: [:edit, :update, :destroy]

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    @book.save
    if @book.save
      redirect_to book_path(@book.id)
      flash[:notice]="You have created book successfully."
    else
    @books = Book.all
    @user = current_user
      render :index
    end
  end

  def index
    @books = Book.all
    @user = current_user
    @book = Book.new
  end

  def show
    @book = Book.find(params[:id])
    @user = current_user
    @books = Book.new

  end

  def destroy
    book = Book.find(params[:id])
    book.delete
    redirect_to books_path
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    @book.update(book_params)
    redirect_to book_path(@book.id)
    if @book.save
      flash[:notice]="You have updated book successfully."
    end
  end

  private

  def ensure_user
    @book = Book.find(params[:id])
      unless @book.user == current_user
        redirect_to books_path
      end
  end


  def book_params
    params.require(:book).permit(:title, :image, :body, :opinion)
  end

end
