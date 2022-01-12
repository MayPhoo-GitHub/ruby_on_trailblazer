module Post::Operation
  class CsvFormat < Trailblazer::Operation
    step :csv_format

    # function csv_format
    # export csv format for post csv upload
    # @return [<Type>] <csv>
    def csv_format(options, **)
      headers = Constants::POST_CSV_FORMAT_HEADER
      options[:csv_format] = CSV.generate(headers: true) do |csv|
        csv << headers
      end
    end
  end
end
