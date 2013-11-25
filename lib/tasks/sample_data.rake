namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    admin = User.create!( name: "Syafiq Kamarul Azman", email: "syafiqkamarulazman@hotmail.com", password: "123123", password_confirmation: "123123", admin: true  )
    User.create!(name: "Example User", email: "example@user.com", password: "foobar", password_confirmation: "foobar")
    99.times do |n|
      name = Faker::Name.name
      email = "faker-#{n+1}@example.com"
      password = "password123"
      User.create!( name: name, email: email, password: password, password_confirmation: password )
    end
  end
end