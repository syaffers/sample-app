class Paper < ActiveRecord::Base
  #relations
  belongs_to :user
  belongs_to :subject
  
  has_many :comments
  
  #validations
  validates :title, presence: true, length: { maximum: 150 }
  validates :subject_id, presence: true
  
  def self.search(search)
    if search
      self.where("title LIKE ?", "%#{search}%")
    end
  end
end
