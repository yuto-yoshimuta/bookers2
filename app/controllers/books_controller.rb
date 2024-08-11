class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy]
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]

  def index
    @books = Book.all
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to @book, notice: 'Book was successfully created.'
    else
      # エラーが発生した場合は、index ビューを再表示します。
      @books = Book.all
      render :index
    end
  end

  def show
  end

  def edit
    @book = Book.find(params[:id])
    @user = @book.user
  end

  def update
    if @book.update(book_params)
      redirect_to books_path
    else
      render :edit
    end
  end

  def destroy
    @book.destroy
    redirect_to books_path
  end

  private

  def set_book
    @book = Book.find(params[:id])
  end

  def ensure_correct_user
    redirect_to books_path unless @book.user == current_user
  end

  def book_params
    params.require(:book).permit(:title, :body, :user_id)
  end
end
