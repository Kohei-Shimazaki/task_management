class TasksController < ApplicationController
  PER = 8
  before_action :set_task, only: %i[edit update show destroy]

  def index
    tasks = current_user.tasks
    tasks = tasks.order_deadline if params[:sort_expired]
    if params.dig(:search, :name).present?
      words = params.dig(:search, :name).split
      tasks = words.inject (tasks){|tasks,word| tasks.search_like_name(word) }
    end
    tasks = tasks.search_status(params.dig(:search, :status)) if params.dig(:search, :status).present?
    tasks = tasks.order_priority if params.dig(:search, :priority).to_i == 1
    tasks = tasks.order_created_at
    tasks = tasks.inject ([]){|tasks,task| tasks.push(task) if task.label_ids.include?(params.dig(:search, :label_ids).to_i); tasks} if params.dig(:search, :label_ids).present?
    @tasks = Kaminari.paginate_array(tasks).page(params[:page]).per(PER)
  end

  def close_to_deadline
    tasks = current_user.tasks.close_to_deadline(Time.current, Time.current + (3 * 60 * 60 * 24))
    tasks = tasks.status_not_completed
    @tasks = tasks.order_created_at
  end

  def new
    @task = Task.new
  end

  def create
    @task = current_user.tasks.build(task_params)
    if @task.save
      flash[:notice] = "タスクを登録しました！"
      redirect_to tasks_path
    else
      render :new
    end
  end

  def edit
  end

  def show
  end

  def update
    if @task.update(task_params)
      flash[:notice] = "タスクを更新しました！"
      redirect_to tasks_path
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    flash[:notice] = "タスクを削除しました！"
    redirect_to tasks_path
  end

  private
  def set_task
    if current_user.tasks.pluck(:id).include?(params[:id].to_i)
      @task = current_user.tasks.find(params[:id])
    else
      redirect_to tasks_path
    end
  end
  def task_params
    params.require(:task).permit(:name,
                                 :content,
                                 :deadline,
                                 :status,
                                 :priority,
                                 label_ids: [] )
  end
end
