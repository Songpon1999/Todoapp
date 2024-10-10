class TasksController < ApplicationController
    before_action :set_task, only: [:destroy, :complete]
  
    def index
      @incomplete_tasks = Task.where(status: 0)
      @complete_tasks = Task.where(status: 1)
      @task = Task.new
    end
  
    def create
        @task = Task.new(task_params)
        @task.status = 0  # Set the status to 0 (incomplete)
        if @task.save
          redirect_to tasks_path, notice: 'Task was successfully created.'
        else
          render :index
        end
    end
  
    def destroy
      @task.destroy
      redirect_to tasks_path, notice: 'Task was successfully deleted.'
    end
  
    def complete
      @task.update(status: 1)
      redirect_to tasks_path, notice: 'Task marked as complete.'
    end
    
    def show
        @task = Task.find(params[:id])
    end
    
    private
  
    def set_task
      @task = Task.find(params[:id])
    end
  
    def task_params
      params.require(:task).permit(:title)
    end
    
  end
  