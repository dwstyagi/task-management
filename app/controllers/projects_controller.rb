class ProjectsController < ApplicationController
  layout 'admin'
  before_action :authenticate_user!
  before_action :set_project, only: [:destroy, :edit, :update, :show]

  def index
    @projects = Project.all
  end

  def create
    @project = current_user.projects.build(project_params)
    if @project.save
      redirect_to projects_path, notice: "Project Created..!!"
    else
      redirect_to projects_path, alert: @project.errors.full_messages.join(",")
    end
  end

  def destroy
    @project.destroy!
    redirect_to projects_path, notice: "Project Deleted"
  end

  def edit
  end

  def show
  end

  def update
    @project.update(project_params)
    if @project.save
      redirect_to projects_path, notice: "Project Updated..!!"
    else
      redirect_to projects_path, alert: @project.errors.full_messages.join(",")
    end
  end

  private

    def project_params
      params.require(:project).permit(:name)
    end

    def set_project
      @project = Project.find(params[:id])
    end
end
