# frozen_string_literal: true

class RecurringTasksController < ApplicationController
  before_action :load_recurring_task, only: %i[show edit update destroy]

  def index
    @recurring_tasks = current_user.recurring_tasks.all
  end

  def show; end

  def new
    @recurring_task = RecurringTask.new
  end

  def edit; end

  def create
    @recurring_task = current_user.recurring_tasks.create recurring_task_params
    tasks(@recurring_task)
  end

  def update
    if params[:task]
      @recurring_task.update(anchor: params[:task][:start])
    else
      @recurring_task.update recurring_task_params
    end
  end

  def destroy
    @recurring_task.destroy
  end

  private

  def recurring_task_params
    params.require(:recurring_task).permit :title, :anchor, :frequency, :color, :limit
  end

  def load_recurring_task
    @recurring_task = RecurringTask.find_by id: params[:id]
  end

  def tasks recurring_task
    array_tasks = recurring_task.tasks(@recurring_task.anchor, Time.now.end_of_month + @recurring_task.limit.month)
    array_tasks.each do |a|
      Task.create(user_id: current_user.id, title: recurring_task.title, start: a.to_date, end: a.to_date, color: recurring_task.color)
    end
  end
end
