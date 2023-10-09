class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :lifehacks, dependent: :destroy
  #いいね機能
  has_many :favorites, dependent: :destroy
  #コメント機能
  has_many :lifehack_comments,  dependent: :destroy

    #検索機能、条件分岐
  def self.search_for(content, method)
    if method == 'perfect'
      User.where(account_name: content)
    elsif method == 'forward'
      User.where('account_name LIKE ?', content + '%')
    elsif method == 'backward'
      User.where('account_name LIKE ?', '%' + content)
    else
      User.where('account_name LIKE ?', '%' + content + '%')
    end
  end

  has_one_attached :profile_image

  def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/no_user_image.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    profile_image.variant(resize_to_limit: [width, height]).processed
  end

end
