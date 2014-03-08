class ReviewsController < ApplicationController
  before_action :signed_in_user, only: [:new, :edit, :update, :destroy]
  before_action :set_review, only: [:show]
  
  def create
    @user = current_user
    @review = Review.new(paper_params)
    
    if @review.save
      flash[:success] = "Review was successfully posted"
      redirect_to @review.paper
    else
      flash[:error] = "Error creating review: #{@review.errors.full_messages}"
      redirect_to @review.paper
    end
  end
  
  def new
    @paper = Paper.find(params[:paper_id])
    @user = current_user
    @review = Review.new({:paper_id => @paper.id, :user_id => @user.id})
  end
  
  def edit
    @review = Review.find(params[:id])
    @user = current_user
    @paper = Paper.find(@review.paper.id)
  end
  
  def show
    @review = Review.find(params[:id])
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
    def set_review
      @review = Review.find(params[:id])
    end
     
    def correct_user
      @review = current_user.reviews.find_by(id: params[:id])
      if @review.nil?
        redirect_to root_url 
        flash[:error] = "Unauthorized access"
      end
    end
  
    # Never trust parameters from the scary internet, only allow the white list through.
    def paper_params
      params.require(:review).permit(:content, :paper_id, :user_id, :review_status)
    end
end