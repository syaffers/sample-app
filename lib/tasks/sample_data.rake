namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    make_users
    make_subjects
  end
end

def make_users
  require Rails.root.join 'lib/faker/academic'
  # create admin
  admin = User.create!( name: "Syafiq Kamarul Azman", email: "syafiqkamarulazman@hotmail.com", password: "123123", password_confirmation: "123123", admin: true, editor: true, institution: "University of Nottingham", job_title: "Student" )
  
  # create 25 users
  20.times do |n|
    name = Faker::Name.name
    company = "University of #{Faker::Address.city}"
    rank = Faker::Academic.rank
    email = "user#{n+1}@example.com"
    password = "password123"
    editor = n%2
    User.create!( name: name, email: email, password: password, password_confirmation: password, institution: company, job_title: rank, editor: editor )
  end
end

def make_subjects
  # create 4 subjects
  Subject.create!(name: "Computer Science")
  Subject.create!(name: "Algebra")
  Subject.create!(name: "Biotechnology")
  Subject.create!(name: "Ancient History")
end