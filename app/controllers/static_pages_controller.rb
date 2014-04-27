class StaticPagesController < ApplicationController
  def home
    if signed_in?
      @reviews = current_user.reviews.where(:review_status => 0)
      
      @matching_papers = match_papers(Paper.all)
    end
  end

  def help
  end
  
  def about
  end
  
  def contact
  end
  
  private
    def match_papers(papers)
      matching_papers = []
      papers.each do |paper|
        if !(paper.user == current_user)
          matching_tags = paper.tag_list & current_user.tag_list
          if matching_tags.count.to_f / paper.tag_list.count > 0.5
            matching_papers << paper
          end
        end
      end
      return matching_papers
    end
end
