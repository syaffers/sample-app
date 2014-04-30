class StaticPagesController < ApplicationController
  def home
    @newest_papers = Paper.order("updated_at desc").limit(3)
    if signed_in?
      @reviews = current_user.reviews.where(:review_status => 0)
      @matching_papers = match_papers(Paper.all)
      @notifications = PublicActivity::Activity.order("created_at desc").where(recipient_id: current_user.id).limit(5)
    end
  end

  def about
    @fund = Fund.first
  end
  
  private
    def match_papers(papers)
      matching_papers = []
      papers.each do |paper|
        if !(paper.user == current_user)
          matching_tags = paper.tag_list & current_user.tag_list
          if !paper.reviews.pluck(:user_id).include? current_user.id
            if matching_tags.count.to_f / paper.tag_list.count > 0.5
              matching_papers << paper
            end
          end
        end
      end
      return matching_papers
    end
end
