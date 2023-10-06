class Lifehack < ApplicationRecord
  has_many :favorites,dependent: :destroy
  has_many :lifehack_comments, dependent: :destroy
  belongs_to :user
end
