class ProjectsController < ApplicationController
  def show
    @project = Project.find(params[:project_id])
    @average_age = @project.contestants.average(:age)
  end

  def create
    project = Project.find(params[:project_id])
    contests = project.contestants.create!(:name, :age, :hometown, :years_of_experience)
    redirect_to "/projects/#{project.id}"
  end
end
