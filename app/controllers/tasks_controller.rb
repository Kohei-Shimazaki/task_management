class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end
  def new
    @task = Task.new
  end
  def create
    @task = Task.new(task_params)
    if @task.save
      flash[:notice] = "タスクを登録しました！"
      redirect_to tasks_path
    else
      render :new
    end
  end
  def edit
    @task = Task.find(params[:id])
  end
  def show
    @task = Task.find(params[:id])
  end
  def update
    @task = Task.find(params[:id])
    if @task.update(task_params)
      flash[:notice] = "タスクを更新しました！"
      redirect_to tasks_path
    else
      render :edit
    end
  end
  def destroy
    @task = Task.find(params[:id]).destroy
    flash[:notice] = "タスクを削除しました！"
    redirect_to tasks_path
  end
  private
  def task_params
    params.require(:task).permit(:name, :content,)
  end
end
