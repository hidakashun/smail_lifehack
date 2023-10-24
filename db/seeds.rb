# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
#user1~20のデータ
20.times do |n|
  User.create!(
    account_name: "テストユーザー#{n + 1}",
    is_active: false,
    email: "test#{n + 1}@test.com",
    introduction: "私はテストユーザー#{n + 1}といいます。よろしくお願いします。",
    password: "000000"
  )
end

#user21~23のデータ
user_data = [
  { email: ENV['USER_EMAIL21'], account_name: "テスト21", is_active: true, password: ENV['USER_PASSWORD21'] },
  { email: ENV['USER_EMAIL22'], account_name: "テスト22", is_active: true, password: ENV['USER_PASSWORD22'] },
  { email: ENV['USER_EMAIL23'], account_name: "テスト23", is_active: true, password: ENV['USER_PASSWORD23'] }
]

user_data.each do |data|
  User.find_or_create_by!(email: data[:email]) do |user|
    user.account_name = data[:account_name]
    user.is_active = data[:is_active]
    user.password = data[:password]
  end
end

#adminのデータ
Admin.find_or_create_by!(email: ENV['ADMIN_EMAIL']) do |admin|
  admin.password = ENV['ADMIN_PASSWORD']
end