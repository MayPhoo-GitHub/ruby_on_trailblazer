# frozen_string_literal: true

class User < ApplicationRecord


  # adds virtual attributes for authentication
  has_secure_password

end
