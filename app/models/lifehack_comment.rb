class LifehackComment < ApplicationRecord
  belongs_to :user
  belongs_to :lifehack
end
