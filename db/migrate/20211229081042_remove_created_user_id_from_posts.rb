class RemoveCreatedUserIdFromPosts < ActiveRecord::Migration[6.1]
  def change
    remove_column :posts, :created_user_id, :integer
  end
end
