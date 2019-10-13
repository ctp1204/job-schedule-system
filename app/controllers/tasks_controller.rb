# frozen_string_literal: true

class TasksController < ApplicationController
  before_action :load_task, only: %i[show edit update destroy]

  def index
    @tasks = current_user.tasks.tasks_of_months(params[:start], params[:end])
  end

  def show; end

  def new
    @task = Task.new
  end

  def edit; end

  def create
    @task = current_user.tasks.build task_params
    @task.save
  end

  def update
    @task.update task_params
  end

  def destroy
    @task.destroy
  end

  private

  def task_params
    params.require(:task).permit :title, :date_range, :start, :end, :progress, :color, :status
  end

  def load_task
    @task = Task.find params[:id]
  end
end
