class ApplicationController < ActionController::Base
  #record controller on each requerst, allows access tinto model
  include PublicActivity::StoreController
  
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  include SessionsHelper
    
end
