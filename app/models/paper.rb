class Paper < ActiveRecord::Base
  #relations
  belongs_to :user
  belongs_to :subject
  
  has_many :comments
  has_many :reviews
  
  #file dependencies
  has_attached_file :pdf,
    :url => "/assets/:attachment/:id/:basename.:extension",
    :path => ":rails_root/public/assets/pdfs/:id/:basename.:extension"
  
  #validations
  validates :title, presence: true, length: { maximum: 150 }
  validates :subject_id, presence: true
  validates :version, presence: true
  validates_attachment_content_type :pdf, :content_type => 'application/pdf'
  
  validates_each :reviews do |paper, attr, value|
    paper.error.add attr, "too many reviews for paper" if paper.reviews.size > paper.review_limit
  end
  
  def self.search(search)
    if search
      self.where("title LIKE ?", "%#{search}%")
    end
  end
end
