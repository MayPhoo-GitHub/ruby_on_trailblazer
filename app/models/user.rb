# frozen_string_literal: true

class User < ApplicationRecord
  has_many :posts, :foreign_key => :created_user_id, :primary_key => :id, :dependent => :delete_all
  # adds virtual attributes for authentication
  has_secure_password
  validates :name, presence: true, length: { maximum: 100 }
  validates :email, presence: true, length: { maximum: 100 }, format: { with: Constants::EMAIL_FORMAT }
  validates :password, presence: true, confirmation: true
  validates :password_confirmation, presence: true
  validates :phone, numericality: true, allow_blank: true, length: { minimum: 10, maximum: 13 }
  validates :address, length: { maximum: 255 }, allow_blank: true
  validates :super_user_flag, presence: true, inclusion: { in: [true, false] }
  validates :birthday, format: { with: Constants::DATE_FORMAT }, allow_blank: true
end
