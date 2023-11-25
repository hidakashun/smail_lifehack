class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :lifehacks, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :lifehack_comments, dependent: :destroy

  validates :account_name, presence: true, length: { minimum: 2, maximum: 20 } # アカウント名最小2文字、最大20文字
  validates :introduction, length: { maximum: 50 } # 紹介文最大50文字

  has_one_attached :profile_image

  # ゲストユーザーを作成するメソッド
  def self.guest
    find_or_create_by!(email: 'guest@example.com', account_name: 'ゲストアカウント') do |user|
      user.password = SecureRandom.urlsafe_base64
      # user.confirmed_at = Time.now  # Confirmable を使用している場合は必要
      # 例えば name を入力必須としているならば， user.name = "ゲスト" なども必要
    end
  end

  # 検索機能、条件分岐
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

  # プロフィール画像を取得するメソッド
  def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/no_user_image.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    profile_image.variant(resize_to_limit: [width, height]).processed
  end
end
