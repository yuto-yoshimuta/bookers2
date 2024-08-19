class FavoritesController < ApplicationController
  def create
    book = Book.find(params[:book_id])
    favorite = current_user.favorites.new(book: book)
    favorite.save
    redirect_back(fallback_location: books_path)
  end

  def destroy
    book = Book.find(params[:book_id])
    favorite = current_user.favorites.find_by(book: book)
    favorite.destroy
    redirect_back(fallback_location: books_path)
  end
end
