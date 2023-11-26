class Lifehack < ApplicationRecord
  # いいね機能
  has_many :favorites, dependent: :destroy

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  # コメント機能
  has_many :lifehack_comments, dependent: :destroy
  belongs_to :user

  # バリデーション

  # 下書き関連
  with_options presence: true, on: :publicize do
    validates :title
    validates :body
    validates :tag
  end

  validates :is_draft, inclusion: { in: [true, false] } # 下書き有無

  validates :title, presence: true, length: { minimum: 2, maximum: 20 } # タイトル最小2文字、最大20文字
  validates :body, presence: true, length: { minimum: 10, maximum: 200 } # 本文最小10文字、最大200文字
  validates :tag, length: { minimum: 2, maximum: 20 } # タグ設定最小2文字、最大20文字

  # 検索機能、条件分岐
  def self.search_for(content, method)
    if method == 'perfect'
      Lifehack.where(title: content)
    elsif method == 'forward'
      Lifehack.where('title LIKE ?', content + '%')
    elsif method == 'backward'
      Lifehack.where('title LIKE ?', '%' + content)
    else
      Lifehack.where('title LIKE ?', '%' + content + '%')
    end
  end

  has_many_attached :lifehack_images # 画像投稿関連

  FILE_NUMBER_LIMIT = 3

  validate :validate_number_of_files

  def validate_number_of_files
    return if lifehack_images.length <= FILE_NUMBER_LIMIT

    errors.add(:画像解説, "に添付できる画像は#{FILE_NUMBER_LIMIT}枚までです。")
  end
end
