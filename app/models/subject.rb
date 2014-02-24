class Subject < ActiveRecord::Base
  validates :name, presence: true, length: { maximum: 150 }
  
  has_many :papers
end
