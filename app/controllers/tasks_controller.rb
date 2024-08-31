class TasksController < ApplicationController
  layout 'admin'
  before_action :authenticate_user!
  before_action :set_task, only: %i[ show edit update destroy ]
  before_action :set_project

  # GET /tasks or /tasks.json
  def index
    @tasks = current_user.tasks
  end

  # GET /tasks/1 or /tasks/1.json
  def show
  end

  # GET /tasks/new
  def new
    @task = @project.tasks.build
  end

  # GET /tasks/1/edit
  def edit
  end

  # POST /tasks or /tasks.json
  def create
    @task = @project.tasks.build(task_params)

    respond_to do |format|
      if @task.save
        format.html { redirect_to project_path(@project), notice: "Task was successfully created." }
      else
        format.html { redirect_to project_path(@project), alert: @task.errors.full_messages.join(",") }
      end
    end
  end

  # PATCH/PUT /tasks/1 or /tasks/1.json
  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to project_path(@project), notice: "Task was successfully updated." }
      else
        format.html { redirect_to project_path(@project), alert: @task.errors.full_messages.join(",") }
      end
    end
  end

  # DELETE /tasks/1 or /tasks/1.json
  def destroy
    pp @task
    @task.destroy!

    respond_to do |format|
      format.html { redirect_to project_path(@project), notice: "Task was successfully destroyed." }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = current_user.tasks.find(params[:id])
    end

    def set_project
      @project = current_user.projects.find(params[:project_id])
    end

    # Only allow a list of trusted parameters through.
    def task_params
      params.require(:task).permit(:name, :due_date, :completed_at, :priority, :project_id, :completed)
    end
end
