class TasksController < ApplicationController
  before_action :set_task, only: %i[ show edit update destroy ]
  skip_before_action :login_required, only: [:new, :create]

  def index
    @tasks = current_user.tasks.order(created_at: "DESC")
    if params[:sort_end].present?
      @tasks = current_user.tasks.order(end_date: :asc)
    end
    if params[:sort_priority].present?
      @tasks = current_user.tasks.order(priority: :asc)
    end
    @tasks = @tasks.page(params[:page]).per(10)

    if params[:task].present?
      if  params[:task][:task_name].present? && params[:task][:status].present?
        @tasks = @tasks.task_name_search("%#{params[:task][:task_name]}%")
        @tasks = @tasks.status_search(params[:task][:status])
      end
      if params[:task][:task_name].present?
        @tasks = @tasks.task_name_search("%#{params[:task][:task_name]}%")
      end
      if params[:task][:status].present?
        @tasks = @tasks.status_search(params[:task][:status])
      end
    end
  end

  def show
  end

  def new
    @task = Task.new
  end

  def edit
  end

  def create
    @task = current_user.tasks.build(task_params)
    
    respond_to do |format|
      if @task.save
        format.html { redirect_to task_url(@task), notice: "task was successfully created." }
        format.json { render :show, status: :created, location: @task }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tasks/1 or /tasks/1.json
  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to task_url(@task), notice: "task was successfully updated." }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1 or /tasks/1.json
  def destroy
    @task.destroy

    respond_to do |format|
      format.html { redirect_to tasks_url, notice: "task was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  
  private
    # Use callbacks to share common setup or constraints between actions.
  def set_task
    @task = Task.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def task_params
    params.require(:task).permit(:task_name, :content, :created_at, :end_date, :status, :priority, :user_id)
  end
end
