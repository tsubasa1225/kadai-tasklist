class TasksController < ApplicationController
  include SessionsHelper
  
  before_action :require_user_logged_in
  before_action :correct_user, only: [:show, :edit, :update, :destroy]
  
  def index
    @tasks = current_user.tasks.order(id: :desc)
  end
  
  def show
  end
  
  def new
    @task = Task.new
  end
  
  def create
    @task = current_user.tasks.build(task_params)
    if @task.save
      flash[:success] = "タスクが正常に作成されました"
      redirect_to @task
    else
      @tasks = current_user.tasks.order(id: :desc)
      flash.now[:danger] = "タスクの作成に失敗しました"
      render :new
    end
  end
  
  def edit
  end
  
  def update
    if @task.update(task_params)
      flash[:success] = "タスクを正常に更新しました"
      redirect_to @task
    else
      flash.now[:danger] = "タスクの更新に失敗しました"
      render :edit
    end
  end
  
  def destroy
    @task.destroy
    
    flash[:success] = "タスクは削除されました"
    redirect_to root_url
  end
  
  private
  
  def task_params
    params.require(:task).permit(:content, :status)
  end
  
  def correct_user
    @task = current_user.tasks.find_by(id: params[:id])
    unless @task
      flash[:no_task] = "タスクがありません"
      redirect_to root_url
    end
  end
end
