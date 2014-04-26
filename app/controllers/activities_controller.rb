class ActivitiesController < ApplicationController
  before_action :signed_in_user
  before_action :authorized_user
  
  def index
    @activities = PublicActivity::Activity.order("created_at desc")
  end
  
  private
    def authorized_user
      redirect_to root_url unless ( current_user.admin? || current_user.editor? )
      #flash[:error] = "Unauthorized access to activities page"
    end
end
