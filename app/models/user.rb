# frozen_string_literal: true

class User < ApplicationRecord
  has_many :posts, :foreign_key => :created_user_id, :primary_key => :id, :dependent => :delete_all
  # adds virtual attributes for authentication
  has_secure_password
end
