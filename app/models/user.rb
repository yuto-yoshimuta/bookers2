class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :books, dependent: :destroy
  has_one_attached :profile_image

  validates :name, presence: true, uniqueness: true, length: { in: 2..20 }
  validates :introduction, length: { maximum: 50 }

  def self.default_image
    @default_image ||= begin
      path = Rails.root.join('app', 'assets', 'images', 'default-image.jpg')
      unless ActiveStorage::Blob.exists?(filename: 'default-image.jpg')
        ActiveStorage::Blob.create_and_upload!(
          io: File.open(path),
          filename: 'default-image.jpg',
          content_type: 'image/jpeg'
        )
      end
      ActiveStorage::Blob.find_by(filename: 'default-image.jpg')
    end
  end

  def get_profile_image(width, height)
    if profile_image.attached?
      profile_image.variant(resize_to_limit: [width, height]).processed
    else
      # デフォルト画像のパスを直接指定
      ActionController::Base.helpers.asset_path('default-image.jpg')
    end
  end
end
