class Comment < ActiveRecord::Base
  #relations
  belongs_to :user
  belongs_to :paper
  
  #validations
  validates :content, presence: true
  validates :paper_id, presence: true
end
