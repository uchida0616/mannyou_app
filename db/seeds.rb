# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# User.create!(name:  "管理者",
#            email: "admin@example.jp",
#            password:  "11111111",
#            password_confirmation: "11111111",
#            admin: true)

10.times do |n|
    name = Faker::Games::Pokemon.name
    email = Faker::Internet.email
    password = "password"
    User.create!(name: name,
                 email: email,
                 password: password,
                 password_confirmation: password,
                 )
  end

10.times do |n|
  title = "タスク#{n}"
  content = "タスクの内容#{n}"
  priority = rand(0..2)
  status = rand(0..2)
  expired_at = DateTime.new(2021,5, rand(1..30) )
  user_id = rand(2..10)

  Task.create!(title: title, content: content, priority: priority, status: status, expired_at: expired_at, user_id: user_id)
end



10.times do |i|
  Label.create!(name: "sample#{i + 1}")
end
