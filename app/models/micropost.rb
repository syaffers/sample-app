class Micropost < ActiveRecord::Base
  # relations
  belongs_to :user
  
  # scope
  default_scope -> { order('created_at DESC') }
  
  #validations
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
  
  # Returns microposts from the users being followed by the given user.
  def self.from_users_followed_by(user)
    followed_user_ids = "SELECT followed_id FROM relationships WHERE follower_id = :user_id"
    where("user_id IN (#{followed_user_ids}) or user_id = :user_id", user_id: user)
  end
end