class PapersController < ApplicationController 
  before_action :signed_in_user, only: [:new, :edit, :update, :destroy, :upvote, :downvote, :publish]
  before_action :enough_accepts, only: [:publish]
  before_action :correct_user, only: [:edit, :update, :destroy, :publish]
  
  # GET /papers
  # GET /papers.json
  def index
    @papers = Paper.search(params[:search])
    @newest_papers = Paper.all.order(:created_at).reverse_order.limit(3)
  end

  # GET /papers/1
  # GET /papers/1.json
  def show
    @paper = Paper.find(params[:id])
    @user = current_user
    @matching_papers = match_papers(@paper, Paper.all.order("updated_at desc"))
    
    if !current_user.nil?
      user_id = current_user.id
    else
      user_id = 0
    end    
    
    @comment = Comment.find_by paper_id: @paper.id
    @commenting = Comment.new( { :user_id => user_id, :paper_id => @paper.id } )
  end

  # GET /papers/new
  def new
    @paper = Paper.new( { :user_id => current_user.id, :version => 1 } )
    4.times { @paper.assets.build }
  end

  # GET /papers/1/edit
  def edit
    @user = User.find(@paper.user.id)
    4.times { @paper.assets.build }
  end

  # POST /papers
  # POST /papers.json
  def create
    @paper = Paper.new(paper_params)

    respond_to do |format|
      if @paper.save
        @paper.create_activity :create, owner: current_user
        format.html { redirect_to @paper, notice: 'Paper was successfully created.' }
        format.json { render action: 'show', status: :created, location: @paper }
      else
        format.html { render action: 'new' }
        format.json { render json: @paper.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /papers/1
  # PATCH/PUT /papers/1.json
  def update
    respond_to do |format|
      if !params[:paper][:pdf].nil?
        params[:paper][:version] = (@paper.version + 1).to_s
      end
      if @paper.update(paper_params)
        @paper.create_activity :update, owner: current_user
        format.html { redirect_to @paper, notice: "Paper was successfully updated." }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @paper.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /papers/1
  # DELETE /papers/1.json
  def destroy
    @paper.destroy
    respond_to do |format|
      format.html { redirect_to user_path(@paper.user.id), notice: "Paper was successfully deleted." }
      format.json { head :no_content }
    end
  end
  
  def browse
    @subjects = Subject.find(:all, :order => "name ASC") #find by paper subject
  end
  
  # Upvote and downvote funcitonality
  def upvote
    @paper = Paper.find(params[:id])
    @paper.create_activity key: 'paper.upvoted', owner: current_user, recipient: @paper.user
    @paper.upvote_from current_user
    flash[:success] = "Successfully upvoted"
    redirect_to @paper
  end
  
  def downvote
    @paper = Paper.find(params[:id])
    @paper.create_activity key: 'paper.downvoted', owner: current_user, recipient: @paper.user
    @paper.downvote_from current_user
    flash[:success] = "Successfully downvoted"
    redirect_to @paper
  end
  
  def change_reviewer
    @paper = Paper.find(params[:id])
    @matching_users = match_users(User.all, @paper)
  end
  
  # Publishing
  def publish
    @paper = Paper.find(params[:id])
    if @paper.reviews.sum("review_status") >= 3
      @paper.create_activity key: 'paper.published', owner: current_user
      @paper.publish
        if @paper.save
          flash[:success] = "Paper successfully published"
        end
    end
    redirect_to @paper
  end
  
  def correct_user?(user)
    user == current_user
  end

  private
    # Use callbacks to share common setup or constraints between actions.    
    def correct_user
      @paper = current_user.papers.find_by(id: params[:id])
      if @paper.nil?
        redirect_to root_url 
        flash[:error] = "Unauthorized paper access"
      end
    end
    
    # match users to paper
    def match_users(users, paper)
      matching_users = []
      users.each do |user|
        matching_tags = paper.tag_list & user.tag_list
        if matching_tags.count.to_f / paper.tag_list.count > 0.5
          matching_users << user
        end
      end
      return matching_users
    end
    
    # match papers to papers
    def match_papers(current_paper, papers)
      matching_papers = []
      papers.each do |paper|
        unless current_paper == paper
          matching_tags = current_paper.tag_list & paper.tag_list
          if matching_tags.count.to_f / current_paper.tag_list.count >= 0.4
            matching_papers << paper
          end
        end
      end
      return matching_papers
    end
    
    # check if paper has enough accepts, else redirect
    def enough_accepts
      @paper = Paper.find(params[:id])
      redirect_to @paper unless @paper.reviews.sum('review_status') >= 3
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def paper_params
      params.require(:paper).permit(:title, :user_id, :subject_id, :pdf, :version, :paper_status, :tag_list, assets_attributes: [:asset, :id, :_destroy])
    end
end
