class SubjectsController < ApplicationController
  before_action :editor_user, only: [:create, :edit, :update, :destroy]
  
  def show
    @subject = subject.find(param[:id])
  end
  
  def new
    @subject = Subject.new()
  end
  
  def create
    @subject = Subject.new(subject_params)
    if @subject.save
      flash[:success] = "Subject was successfully created"
      redirect_to subjects_path
    else
      render action: 'new'
    end
  end

  def edit
    @subject = Subject.find(params[:id])
  end
  
  def update
    @subject = Subject.find(params[:id])
    
    if @subject.update(subject_params)
      flash[:success] = "Subject was successfully changed"
      redirect_to subjects_path
    else
      render action: 'edit'
    end
  end
  
  def destroy
    Subject.find(params[:id]).destroy
    flash[:success] = "Subject deleted"
    redirect_to subjects_path
  end
  
  def index
    @subjects = Subject.all
  end
  
  private
    def subject_params
      params.require(:subject).permit(:name)
    end
    
    def admin_user
      redirect_to root_url unless current_user.admin?
    end
    
    def editor_user
      redirect_to root_url unless current_user.editor?
    end
end
