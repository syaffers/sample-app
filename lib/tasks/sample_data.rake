namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    # create admin
    admin = User.create!( name: "Syafiq Kamarul Azman", email: "syafiqkamarulazman@hotmail.com", password: "123123", password_confirmation: "123123", admin: true  )
    
    # create 100 users
    User.create!(name: "Example User", email: "example@user.com", password: "foobar", password_confirmation: "foobar")
    99.times do |n|
      name = Faker::Name.name
      email = "faker-#{n+1}@example.com"
      password = "password123"
      User.create!( name: name, email: email, password: password, password_confirmation: password )
    end
    
    # create 50 microposts for 6 users
    users = User.all(limit: 6)
    50.times do
      content = Faker::Lorem.sentence(5)
      users.each { |user| user.microposts.create!(content: content) }
    end
  end
end