module PapersHelper
  def comment_user?(comment)
    comment.user == current_user
  end
  
  def paper_user?(paper)
    paper.user == current_user
  end
  
  def review_user?(review)
    review.user == current_user
  end
  
  def has_reviewed?(paper)
    paper.reviews.each do |r|
      r.user == current_user
    end
  end
  
  def review_status(status)
    if status == 1
      "accept"
    else 
      "change"
    end
  end
  
  def accepted_reviews_for(paper)
    paper.reviews.sum("review_status")
  end
end
