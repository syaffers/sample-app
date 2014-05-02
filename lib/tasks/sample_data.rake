namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    make_users
    make_subjects
    make_fund
  end
end

def make_users
  require Rails.root.join 'lib/faker/academic'
  # create admin
  admin = User.create!( name: "John Admin Smith", email: "admin@example.com", password: "123123", password_confirmation: "123123", admin: true, editor: true, institution: "University of Nottingham", job_title: "Researcher" )
  
  # create 25 users
  20.times do |n|
    name = Faker::Name.name
    company = "University of #{Faker::Address.city}"
    rank = Faker::Academic.rank
    
    tags = []
    while tags.size < 6
      tags << Faker::Academic.tag
    end
    
    email = "user#{n+1}@example.com"
    password = "password123"
    editor = n%2
    User.create!( name: name, email: email, password: password, password_confirmation: password, institution: company, job_title: rank, editor: editor, tag_list: tags )
  end
end

def make_subjects
  # create 4 subjects
  Subject.create!(name: "Computer Science")
  Subject.create!(name: "Algebra")
  Subject.create!(name: "Biotechnology")
  Subject.create!(name: "Classical History")
end

def make_fund
  Fund.create!(needed: 1000.0, collected: 462.73)
end