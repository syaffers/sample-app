class ReviewsController < ApplicationController
  before_action :signed_in_user, only: [:new, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]
  before_action :own_paper, only: [:new]
  before_action :double_review, only: [:new]
  before_action :review_limit, only: [:new]
  
  def show
    @review = Review.find(params[:id])
  end
  
  def new
    @paper = Paper.find(params[:paper_id])
    @user = current_user
    @review = Review.new({:paper_id => @paper.id, :user_id => @user.id})
  end
  
  def create
    @user = current_user
    @review = Review.new(review_params)
    
    if @review.save
      @review.create_activity :create, owner: current_user, recipient: @review.paper.user
      flash[:success] = "Review was successfully posted"
      redirect_to @review
    else
      flash[:error] = "Error creating review: #{@review.errors.full_messages}"
      redirect_to @review
    end
  end
  
  def edit
    @review = Review.find(params[:id])
    @user = current_user
    @paper = Paper.find(@review.paper.id)
  end
  
  def update
    respond_to do |format|
      if @review.update(review_params)
        @review.create_activity :update, owner: current_user, recipient: @review.paper.user
        format.html { redirect_to @review, notice: "Review was successfully updated." }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def destroy
    @review = Review.find(params[:id])
    @review.destroy
    
    flash[:success] = "Review removed"
    redirect_to @review.paper
  end
  
  private     
    def correct_user
      @review = current_user.reviews.find_by(id: params[:id])
      if @review.nil?
        redirect_to root_url 
        flash[:error] = "Unauthorized access."
      end
    end
    
    def review_limit
      @paper = Paper.find(params[:paper_id])
      if @paper.reviews.size >= 3
        redirect_to paper_path(@paper)
        flash[:error] = "No more reviews can be made for this paper."
      end
    end
    
    # users should not be able to review their own papers
    def own_paper
      @paper = Paper.find(params[:paper_id])
      if @paper.user == current_user
        redirect_to user_path(current_user)
        flash[:error] = "You cannot review your own paper"
      end
    end
    
    # users shout not be able to put in more than one review to one paper
    def double_review
      @paper = Paper.find(params[:paper_id])
      @paper.reviews.each do |r|
        if r.user == current_user
          redirect_to paper_path(@paper)
          flash[:error] = "You have already made a review for this paper. Please edit the current review."
        end
      end
    end
  
    # Never trust parameters from the scary internet, only allow the white list through.
    def review_params
      params.require(:review).permit(:content, :paper_id, :user_id, :review_status)
    end
end