class Review < ActiveRecord::Base
  #relations
  belongs_to :user
  belongs_to :paper
  
  #validations
  validates :content, presence: true
  validates :paper_id, presence: true
  validates :user_id, presence: true
  validates :review_status, presence: true
  
  validates_associated :paper, :message => "No more reviews can be added for this paper"
end
