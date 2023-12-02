class Notification < ApplicationRecord
  default_scope -> { order(created_at: 'DESC') }

  belongs_to :lifehack, optional: true
  belongs_to :lifehack_comment, optional: true
  belongs_to :favorite, optional: true

  belongs_to :visitor, class_name: 'User', optional: true
  belongs_to :visited, class_name: 'User', optional: true
end
