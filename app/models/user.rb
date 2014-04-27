class User < ActiveRecord::Base
  acts_as_voter
  acts_as_taggable
  
  # before filters
  before_save { email.downcase! }
  before_create :create_remember_token
  
  # relations
  has_many :papers, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :reviews, dependent: :destroy
  
  # validations
  validates( :name, presence: true, length: { maximum: 50 } )
  
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates( :email, presence:    true, 
                     format:      { with: VALID_EMAIL_REGEX }, 
                     uniqueness:  { case_sensitive: false } )
                                     
  validates( :password, length: { minimum: 6 }, :on => :create)
  
  validates( :job_title, presence: true )
  
  validates( :institution, presence: true )
                                     
  has_secure_password
  
  # auxiliary functions
  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end
  
  def User.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end
  
  private
    
    def create_remember_token
      self.remember_token = User.encrypt(User.new_remember_token)
    end
end
