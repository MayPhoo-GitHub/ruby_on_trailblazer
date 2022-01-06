module Constants
  POST_CSV_HEADER = ["id", "title", "description", "public_flag", "name"]
  POST_CSV_FORMAT_HEADER = ["title", "description", "public_flag"]
  EMAIL_FORMAT = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  DATE_FORMAT = /\d{4}-\d{2}-\d{2}/
end
