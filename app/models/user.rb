class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :books, dependent: :destroy
  has_one_attached :profile_image

  validates :name, presence: true, uniqueness: true, length: { in: 2..20 }
  validates :introduction, length: { maximum: 50 }

  def self.default_image
    @default_image ||= ActiveStorage::Blob.create_and_upload!(
      io: File.open(Rails.root.join('app/assets/images/default-image.jpg')),
      filename: 'default-image.jpg',
      content_type: 'image/jpeg'
    )
  end

  def get_profile_image(width, height)
    if profile_image.attached?
      profile_image.variant(resize_to_limit: [width, height]).processed
    else
      Rails.cache.fetch("default_image_#{width}_#{height}", expires_in: 1.day) do
        self.class.default_image.variant(resize_to_limit: [width, height]).processed
      end
    end
  end
end
