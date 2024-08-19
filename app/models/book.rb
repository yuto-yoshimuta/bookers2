class Book < ApplicationRecord

  validates :title, presence: true
  validates :body, presence: true, length: { maximum: 200 }

  has_one_attached :image
  has_many :book_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  belongs_to :user

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end
  
end
