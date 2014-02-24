class Paper < ActiveRecord::Base
  validates :title, presence: true, length: { maximum: 150 }
  validates :subject_id, presence: true
  
  belongs_to :user
  belongs_to :subject
  
  def self.search(search)
    if search
      find(:all, :conditions => ["title LIKE ?", "%#{search}%"])
    else
      find(:all)
    end
  end
end
