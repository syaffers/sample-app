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
  has_attached_file :pdf,
    :styles => { :pdf_thumbnail => ["200x283#", :png] },
    :url => "/assets/:attachment/:id/:basename.:extension",
    :path => ":rails_root/public/assets/papers/:id/:basename.:extension",
    :keep_old_files => true
    
  has_attached_file :ifile1,
    :styles => { :thumb => ["100x100#", :png] },
    :url => "/assets/:attachment/:id/:basename.:extension",
    :path => ":rails_root/public/assets/papers/:id/support/:basename.:extension"
    
  has_attached_file :ifile2,
    :styles => { :thumb => ["100x100#", :png] },
    :url => "/assets/:attachment/:id/:basename.:extension",
    :path => ":rails_root/public/assets/papers/:id/support/:basename.:extension"
  
  has_attached_file :sfile,
    :url => "/assets/:attachment/:id/:basename.:extension",
    :path => ":rails_root/public/assets/papers/:id/support/:basename.:extension"
    
  has_attached_file :vfile,
    :styles => { :thumb => ["100x100#", :png] },
    :url => "/assets/:attachment/:id/:basename.:extension",
    :path => ":rails_root/public/assets/papers/:id/support/:basename.:extension"
  
  #validations
  validates :title, presence: true, length: { maximum: 150 }
  validates :subject_id, presence: true
  validates :version, presence: true
  validates_attachment_content_type :pdf, 
    :content_type => 'application/pdf'
  validates_attachment_content_type :ifile1, 
    :content_type => ['image/gif','image/jpeg','image/png']
  validates_attachment_content_type :ifile2, 
    :content_type => ['image/gif','image/jpeg','image/png']
  validates_attachment_content_type :sfile, 
    :content_type => ['audio/mpeg','audio/ogg','audio/vnd.wave']
  validates_attachment_content_type :vfile, 
    :content_type => ['video/avi','video/mp4','video/x-flv']
  
  attr_accessor :ifile1_file_name
  attr_accessor :ifile1_content_type
  attr_accessor :ifile1_file_size
  attr_accessor :ifile1_updated_at
  
  attr_accessor :ifile2_file_name
  attr_accessor :ifile2_content_type
  attr_accessor :ifile2_file_size
  attr_accessor :ifile2_updated_at
  
  attr_accessor :sfile_file_name
  attr_accessor :sfile_content_type
  attr_accessor :sfile_file_size
  attr_accessor :sfile_updated_at
  
  attr_accessor :vfile_file_name
  attr_accessor :vfile_content_type
  attr_accessor :vfile_file_size
  attr_accessor :vfile_updated_at
  
  validates_each :reviews do |paper, attr, value|
    paper.error.add attr, "too many reviews for paper" if paper.reviews.size > paper.review_limit
  end
  
  def self.search(search)
    if search
      self.where("title LIKE ?", "%#{search}%")
    end
  end
end
