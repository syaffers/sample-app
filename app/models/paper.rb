class Paper < ActiveRecord::Base
  include AASM  
  acts_as_votable
  acts_as_taggable
  include PublicActivity::Common
    
  #relations
  belongs_to :user
  belongs_to :subject
  
  has_many :comments, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :assets
  accepts_nested_attributes_for :assets, :allow_destroy => true

  #paper states
  aasm_column :state
  aasm do
    state :submitted, :initial => true
    state :published
    state :rejected
  
    event :publish_paper do
      transitions :from => :submitted, :to => :published
    end
    
    event :reject_paper do
      transitions :from => :submitted, :to => :rejected
    end
  end
  
  #file dependencies
  has_attached_file :pdf,
    :styles => { :pdf_thumbnail => ["200x283#", :png] },
    :url => "/assets/papers/:id/transpub-:paper_id-v:paper_version.:extension",
    :path => ":rails_root/public/assets/papers/:id/transpub-:paper_id-v:paper_version.:extension",
    :keep_old_files => true
  
  #validations
  validates :title, presence: true, length: { maximum: 150 }
  validates :subject_id, presence: true
  validates :pdf, presence: true
  validates :version, presence: true
  
  #pdf only validation
  validates_attachment_content_type :pdf, 
    :content_type => 'application/pdf'
    
  #limit to 5 tags
  validates_length_of :tag_list, :maximum => 5
  
  validates_each :reviews do |paper, attr, value|
    paper.error.add attr, "too many reviews for paper" if paper.reviews.size > 3
  end
  
  ## Functions ##
  # for paper versioning into filename
  Paperclip.interpolates :paper_version do |attachment, style|
    attachment.instance.version
  end
  
  # for paper title
  Paperclip.interpolates :paper_id do |attachment, style|
    attachment.instance.id
  end
  
  def self.search(search)
    if search
      self.where("title LIKE ?", "%#{search}%")
    end
  end
end
