class CommentsController < ApplicationController
  before_action :correct_user, only: [:destroy]
  
  def create
    @user = current_user
    @comment = Comment.new(paper_params)
    
    if @comment.save
      flash[:notice] = "Comment was successfully posted"
      redirect_to @comment.paper
    else
      flash[:error] = "Error creating comment: #{@comment.errors.full_messages}"
      redirect_to @comment.paper
    end
  end
  
  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    
    flash[:success] = "Comment removed"
    redirect_to @comment.paper
  end
  
  private
  
    def correct_user
      @comment = current_user.comments.find_by(id: params[:id])
      if @comment.nil?
        redirect_to root_url 
        flash[:error] = "Unauthorized comment deletion"
      end
    end
  
    # Never trust parameters from the scary internet, only allow the white list through.
    def paper_params
      params.require(:comment).permit(:content, :paper_id, :user_id)
    end
end