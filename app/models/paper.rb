class Paper < ActiveRecord::Base
  include AASM  
  acts_as_votable
  include PublicActivity::Common
    
  #relations
  belongs_to :user
  belongs_to :subject
  
  has_many :comments, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :likes, dependent: :destroy

  #paper states
  aasm_column :state
  aasm do
    state :under_review, :initial => true
    state :published
  
    event :publish do
      transitions :from => :under_review, :to => :published
    end
  end
  
  #file dependencies
  time = Time.now.to_formatted_s(:number)
  has_attached_file :pdf,
    :styles => { :pdf_thumbnail => ["200x283#", :png] },
    :url => "/assets/:attachment/:id/:basename#{time}.:extension",
    :path => ":rails_root/public/assets/pdfs/:id/:basename#{time}.:extension",
    :keep_old_files => true
  
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
