class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :lifehacks,     dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :lifehack_comments,  dependent: :destroy
end
