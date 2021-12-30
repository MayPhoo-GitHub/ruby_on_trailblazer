# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.destroy_all

User.create!([
  {
    name: "Admin",
    email: "admin@gmail.com",
    password: "admin123",
    phone: "09401245003",
    address: " Yangon",
    birthday: "1998-09-03",
    super_user_flag: true,
  },
  {
    name: "User",
    email: "user@gmail.com",
    password: "user1234",
    phone: "09401245003",
    address: " Yangon",
    birthday: "1998-09-03",
    super_user_flag: false,
  },
])

Post.destroy_all
Post.create!([
  {
    title: "Testing",
    description: "This is test post",
    public_flag: true,
    created_user_id: 1,
  },
])

p "Created #{User.count} users"
p "Created #{Post.count} posts"
