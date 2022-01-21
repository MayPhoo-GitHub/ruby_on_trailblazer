class Post < ApplicationRecord
  belongs_to :user, :foreign_key => :created_user_id, :primary_key => :id, optional: true

  # uncomment for RSpec testing
  # validates  :title, presence: true,length: { maximum: 255 }
  # validates  :description, presence: true, length: { minimum: 10, maximum: 1000 }
  # validates  :public_flag, presence: true
  # validates  :created_user_id, presence: true
end
