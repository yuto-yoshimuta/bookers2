class BookCommentsController < ApplicationController
  before_action :set_book_comment, only: [:destroy]

  def create
    book = Book.find(params[:book_id])
    comment = current_user.book_comments.new(book_comment_params)
    comment.book_id = book.id
    comment.save
    redirect_to book_path(book)
  end

  def show
    @book = Book.find(params[:id])
    @book_comment = BookComment.new
  end

  def destroy
    if @book_comment && @book_comment.user == current_user
      @book_comment.destroy
      redirect_to book_path(@book_comment.book)
    else
      redirect_to books_path
    end
  end

  private

  def set_book_comment
    @book_comment = BookComment.find_by(id: params[:id])
  end

  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end
end
