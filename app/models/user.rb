class User < ApplicationRecord
  has_many :posts, :foreign_key => :created_user_id, :primary_key => :id, :dependent => :delete_all

  before_save :email_downcase
  validates :name, presence: true, length: { maximum: 100 }
  validates :email, presence: true, uniqueness: true, format: { with: /\A[^@\s]+@[^@\s]+\z/ }
  validates :password, confirmation: true, presence: true, length: { minimum: 8 }, on: :create
  validates :phone, numericality: true, length: { minimum: 10, maximum: 15 }, allow_blank: true
  validates :address, length: { maximum: 255 }, allow_blank: true
  validates_inclusion_of :super_user_flag, :in => [true, false]
  has_secure_password

  private

  def email_downcase
    self.email = email.downcase
  end
end
