class Micropost < ActiveRecord::Base
  
  # relations
  belongs_to :user
  
  # scope
  default_scope -> { order('created_at DESC') }
  
  #validations
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
  
end
