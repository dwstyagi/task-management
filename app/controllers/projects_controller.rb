class ProjectsController < ApplicationController
  layout "admin"
  before_action :authenticate_user!
  before_action :authenticate_owner!, only: %i[create edit update destroy]
  before_action :set_project, only: [:destroy, :edit, :update, :show]

  def index
    if current_user.organisation_owner?
      @pagy, @projects = pagy(Project.includes(:tasks), limit: 5)
    else
      @pagy, @projects = pagy(current_user.projects.includes(:tasks), limit: 5)
    end
  end

  def create
    @project = Project.new(project_params)
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
    if current_user.organisation_owner? || current_user.has_role?(:team_leader)
      @pagy, @tasks = pagy(@q.result.incomplete_first, limit: 5)
    else
      @pagy, @tasks = pagy(@q.result.incomplete_first.where(assignee: current_user), limit: 5)
    end
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
    params.require(:project).permit(:name, :team_id)
  end

  def set_project
    @project = if current_user.organisation_owner?
        Project.find(params[:id])
      else
        current_user.project.find(params[:id])
      end
  end
end
