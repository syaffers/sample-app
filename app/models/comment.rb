class Comment < ActiveRecord::Base
  #include public activity tracker
  include PublicActivity::Common
  
  #relations
  belongs_to :user
  belongs_to :paper
  
  #validations
  validates :content, presence: true
  validates :paper_id, presence: true
  validates :user_id, presence: true
end
