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

    #検索機能、条件分岐
  def self.search_for(content, method)
    if method == 'perfect'
      Lifehack.where(title: content)
    elsif method == 'forward'
      Lifehack.where('title LIKE ?', content+'%')
    elsif method == 'backward'
      Lifehack.where('title LIKE ?', '%'+content)
    else
      Lifehack.where('title LIKE ?', '%'+content+'%')
    end
  end

end
