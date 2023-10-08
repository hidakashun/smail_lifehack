class Lifehack < ApplicationRecord
  has_many_attached :lifehack_images
  #いいね機能
  has_many :favorites,dependent: :destroy
  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end
  #コメント機能
  has_many :lifehack_comments, dependent: :destroy
  belongs_to :user

end
