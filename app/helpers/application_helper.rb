module ApplicationHelper
  
  # Returns the full title on a per-page basis
  def full_title( page_title )
    base_title = "TransPub"
    if page_title.empty?
      "#{base_title} - Publish your papers for free transparently!"
    else
      "#{base_title} | #{page_title}"
    end
  end
end
