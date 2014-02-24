class SubjectsController < ApplicationController
  def create
    @subject = Subject.new(subject_params)
  end
end
