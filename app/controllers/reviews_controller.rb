class ReviewsController < ApplicationController
  before_action :authorized_user, only: [:new, :destroy, :edit]
  
  def create
    @user = current_user
    @review = Comment.new(paper_params)
    
    if @review.save
      flash[:success] = "Review was successfully posted"
      redirect_to @review.paper
    else
      flash[:error] = "Error creating review: #{@comment.errors.full_messages}"
      redirect_to @review.paper
    end
  end
  
  def destroy
    @review = Review.find(params[:id])
    @review.destroy
    
    flash[:success] = "Review removed"
    redirect_to @review.paper
  end
  
  def show
    @review = Review.find(params[:id])
  end
  
  private
  
    def correct_user
      @comment = current_user.comments.find_by(id: params[:id])
      false unless @comment
    end
    
    def admin_user
      current_user.admin?
    end
    
    def authorized_user
      admin_user || correct_user
    end
  
    # Never trust parameters from the scary internet, only allow the white list through.
    def paper_params
      params.require(:comment).permit(:content, :paper_id, :user_id)
    end
end