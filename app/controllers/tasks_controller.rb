class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    @tasks = Task.all
    @tasks = @tasks.order(expired_at: :asc) if params[:sort_expired]
    @tasks = @tasks.order(priority: :asc) if params[:sort_priority_high]

    @tasks = @tasks.search_title(params[:title]) if params[:title].present?
    @tasks = @tasks.search_status(params[:status]) if params[:status].present?
    @tasks = @tasks.page(params[:page]).per(5)
 end

  def new
    @task = Task.new
  end

  def create
    @task=Task.new(task_params)
    if params[:back]
      render :new
    else
      if @task.save
        redirect_to tasks_path, notice: "ブログを作成しました！"
      else
        render :new
      end
    end
  end

  def show
  end

  def edit
  end

  def update
    if @task.update(task_params)
      redirect_to tasks_path, notice: "タスクを編集しました！"
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_path, notice: "タスクを削除しました！"
  end

  def confirm
    @task = Task.new(task_params)
    render :new if @task.invalid?
  end

  private
  def task_params
    params.require(:task).permit(:title, :content, :expired_at, :status, :priority)
  end

  def set_task
    @task = Task.find(params[:id])
  end
end
