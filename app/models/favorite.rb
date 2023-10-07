class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :lifehack
  validates_uniqueness_of :lifehack_id, scope: :user_id
  #user_id という範囲内で
  #あるlifehack_idに対して、1つだけfavoriteの値を保存することができる
  #=> 1ユーザーが 1投稿に対して 1つだけ いいねデータを保存できる。
end
