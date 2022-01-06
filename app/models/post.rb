class Post < ApplicationRecord
    belongs_to :user, :foreign_key => :created_user_id, :primary_key => :id, optional: true, :dependent => :destroy
end
