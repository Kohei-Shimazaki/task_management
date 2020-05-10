class TasksController < ApplicationController
  def index
    tasks = Task.all
    if params[:search].present?
      if params[:search][:name].present?
        words = params[:search][:name].split
        words.each do |word|
          tasks = tasks.search_task_name(word)
        end
      end
      if params[:search][:status].present?
        tasks = tasks.search_task_status(params[:search][:status])
      end
    end
    if params[:sort_expired]
      tasks = tasks.all.order(deadline: "DESC")
    end
    @tasks = tasks.order_created_at
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
    params.require(:task).permit(
                                :name,
                                :content,
                                :deadline,
                                :status,
                              )
  end
end
