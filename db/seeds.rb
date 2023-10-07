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
      account_name: "テスト１",
      is_active: "false",
      email: 'test@test.com',
      password: '000000'
    },
    {
      account_name: "テスト２",
      is_active: "false",
      email: 'test2@test2.com',
      password: '222222'
    },
    {
      account_name: "テスト２",
      is_active: "true",
      email: 'test3@test3.com',
      password: '333333'
    }
  ]
)


Admin.create!(
  email: 'testc@testc.com',
  password: '111111'
)