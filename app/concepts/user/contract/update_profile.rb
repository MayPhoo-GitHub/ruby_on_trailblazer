module User::Contract
    class UpdateProfile < Reform::Form
        property :name
        property :email
        property :phone
        property :address
        property :birthday
        property :super_user_flag
  
        validates :name, presence: true, length: { maximum: 50 }
        validates :email, presence: true, length: { maximum: 50 },
                          format: { with: Constants::EMAIL_FORMAT }
        validates :phone, numericality: true, allow_blank: true, length: { minimum: 10}
        validates :address, length: { maximum: 255 }, allow_blank: true
        validates :birthday, format: { with: Constants::DATE_FORMAT }, allow_blank: true
    end
  end
  