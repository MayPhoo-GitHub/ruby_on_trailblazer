module Post::Contract
  class Import < Reform::Form
    property :file, virtual: true
    validates :file, presence: true
    validate :check_header

    def check_header
      if (!errors[:file].any?)
        expected_header = Constants::POST_CSV_FORMAT_HEADER
        input_header = CSV.open(file, "r", encoding: "iso-8859-1:utf-8") { |csv| csv.first }
        error = ""
        if input_header != expected_header
          errors.add(:file, Messages::WRONG_HEADER)
        else
          (0..input_header.size - 1).each do |col_name|
            if (input_header[col_name] == nil || input_header[col_name].downcase != expected_header[col_name].downcase)
              errors.add(:file, Messages::WRONG_COLUMN)
            end
          end
        end
      end
    end
  end
end
