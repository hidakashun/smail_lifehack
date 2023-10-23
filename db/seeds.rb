# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


User.create!(
  [
    {
      account_name: "テスト21",
      is_active: "true",
      email: 'test21@test.com',
      password: '000000'
    },
    {
      account_name: "テスト22",
      is_active: "true",
      email: 'test22@test.com',
      password: '000000'
    },
    {
      account_name: "テスト23",
      is_active: "true",
      email: 'test23@test.com',
      password: '000000',
    }
  ]
)

Admin.create!(
  email: 'testc@testc.com',
  password: '111111'
)
