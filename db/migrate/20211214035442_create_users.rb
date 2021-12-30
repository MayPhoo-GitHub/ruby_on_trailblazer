class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :name, null: false, unique: true
      t.string :email, null: false, unique: true
      t.text :password_digest, null: false
      t.string :phone
      t.string :address
      t.date :birthday
      t.boolean :super_user_flag, null: false
      t.timestamps
      t.datetime :deleted_at
    end
  end
end
