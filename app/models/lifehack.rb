class Lifehack < ApplicationRecord
  has_one_attached :lifehack_image
  #いいね機能
  has_many :favorites,dependent: :destroy
  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end
  #コメント機能
  has_many :lifehack_comments, dependent: :destroy
  belongs_to :user

  def get_lifehack_image(width, height)
    unless lifehack_image.attached?
      file_path = Rails.root.join('app/assets/images/no_lifehack_image.jpg')
      lifehack_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    lifehack_image.variant(resize_to_limit: [width, height]).processed
  end

end
