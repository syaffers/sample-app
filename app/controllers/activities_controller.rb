class ActivitiesController < ApplicationController
  before_action :signed_in_user
  before_action :authorized_user
  
  def index
    @paper_activities = PublicActivity::Activity.order("updated_at desc").where(:trackable_type => "Paper", :key => ['paper.update','paper.create'])
    @review_activities = PublicActivity::Activity.order("updated_at desc").where(:trackable_type => "Review", :key =>['review.update','review.create'])
  end
  
  private
    def authorized_user
      redirect_to root_url unless ( current_user.admin? || current_user.editor? )
      #flash[:error] = "Unauthorized access to activities page"
    end
end
