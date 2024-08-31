class ProjectsController < ApplicationController
  layout 'admin'
  before_action :authenticate_user!
  before_action :set_project, only: [:destroy, :edit, :update, :show]

  def index
    @pagy, @projects = pagy(current_user.projects.includes(:tasks), limit: 5)
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
    @q = @project.tasks.ransack(params[:q])
    @pagy, @tasks = pagy(@q.result.incomplete_first, limit: 5)
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
      @project = current_user.projects.find(params[:id])
    end
end
