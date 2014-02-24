namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    make_users
    make_subjects
    make_papers
    make_relationships
  end
end

def make_users
  # create admin
  admin = User.create!( name: "Syafiq Kamarul Azman", email: "syafiqkamarulazman@hotmail.com", password: "123123", password_confirmation: "123123", admin: true  )
  
  # create 25 users
  25.times do |n|
    name = Faker::Name.name
    email = "faker-#{n+1}@example.com"
    password = "password123"
    User.create!( name: name, email: email, password: password, password_confirmation: password )
  end
end

def make_papers
  # create 4 papers for 6 users
  users = User.all(limit: 6)
  4.times do |n|
    title = Faker::Lorem.sentence(6)
    url = "http://example.com/paper/#{n+1}"
    subject = ((n+1)%4)+1
    users.each { 
      |user| user.papers.create!(title: title, url: url, subject_id: subject)
    }
  end
end

def make_subjects
  # create 4 subjects
  4.times do
    name = Faker::Lorem.sentence(2)
    Subject.create!(name: name)
  end
end

def make_relationships
  users = User.all
  user = users.first
  followed_users = users[2..10]
  followers = users[11..25]
  followed_users.each { |followed| user.follow!(followed) }
  followers.each { |follower| follower.follow!(user) }
end