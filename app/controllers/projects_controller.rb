class ProjectsController < ApplicationController
  def show
    @project = Project.find(params[:project_id])
    @average_age = @project.contestants.average(:age)
  end
end
