class Paper < ActiveRecord::Base
  validates :title, presence: true, length: { maximum: 150 }
  validates :subject_field, presence: true, length: { maximum: 100 }
  
  belongs_to :user
  
  def self.search(search)
    if search
      find(:all, :conditions => ["title LIKE ?", "%#{search}%"])
    else
      find(:all)
    end
  end
end
