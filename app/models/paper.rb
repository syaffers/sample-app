class Paper < ActiveRecord::Base
  belongs_to :user
  
  def self.search(search)
    if search
      find(:all, :conditions => ["title LIKE ?", "%#{search}%"])
    else
      find(:all)
    end
  end
end
