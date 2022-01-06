module Post::Contract
    class Create < Reform::Form
      property :title
      property :description
      property :public_flag
      property :created_user_id
      property :updated_user_id
  
      validates  :title, presence: true, length: { minimum: 10 }
      validates  :description, presence: true, length: { minimum: 20 }
      validates  :public_flag, presence: true
    end
  end
  