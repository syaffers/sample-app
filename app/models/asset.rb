class Asset < ActiveRecord::Base
  belongs_to :paper
  has_attached_file :asset,
    :url => "/assets/papers/:paper_id_asset/:filename",
    :path => ":rails_root/public/assets/papers/:paper_id_asset/:filename"
    
  validates_attachment_content_type :asset, 
    :content_type => ["image/jpeg", "image/gif", "image/png","audio/mpeg",
                                        "audio/ogg", "video/avi", "video/mp4"]
                                        
  Paperclip.interpolates :paper_id_asset do |attachment, style|
    attachment.instance.paper.id
  end
  
end
