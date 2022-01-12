module User::Contract
  class Create < Reform::Form
    property :name
    property :email
    property :password
    property :password_confirmation, virtual: true
    property :phone
    property :address
    property :birthday
    property :super_user_flag

    validates :name, presence: true, length: { maximum: 50 }
    validates :email, presence: true, length: { maximum: 50 },
                      format: { with: Constants::EMAIL_FORMAT }
    validates :password, presence: true, confirmation: true
    validates :password_confirmation, presence: true
    validates :phone, numericality: true, allow_blank: true, length: { minimum: 10 }
    validates :address, length: { maximum: 255 }, allow_blank: true
    validates :birthday, format: { with: Constants::DATE_FORMAT }, allow_blank: true
    validates :super_user_flag, presence: true, inclusion: { in: %w[true false] }
  end
end
