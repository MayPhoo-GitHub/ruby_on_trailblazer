class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.string :title
      t.text :description
      t.boolean :public_flag
      t.bigint :created_user_id
      t.bigint :updated_user_id
      t.datetime :deleted_at
      t.timestamps
    end
  end
end
