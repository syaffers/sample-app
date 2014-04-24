class Likes < ActiveRecord::Base
  # track likes
  include PublicActivity::Common
  
  belongs_to :user
  belongs_to :paper
end
