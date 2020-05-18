class TasksController < ApplicationController
  PER = 8
  before_action :set_task, only: [:edit, :update, :show, :destroy]
  before_action :prohibit_other_user, only: [:edit, :show,]
  def index
    tasks = current_user.tasks
    if params[:sort_expired]
      tasks = tasks.order_deadline
    end
    if params[:search].present?
      if params[:search][:name].present?
        words = params[:search][:name].split
        words.each do |word|
          tasks = tasks.search_like_name(word)
        end
      end
      if params[:search][:status].present?
        tasks = tasks.search_status(params[:search][:status])
      end
      if params[:search][:priority].to_i == 1
        tasks = tasks.order_priority
      end
    end
    tasks = tasks.order_created_at
    if params[:search].present?
      if params[:search][:label_ids].present?
        tasks_clone = []
        tasks.each do |task|
          if task.label_ids.include?(params[:search][:label_ids].to_i)
            tasks_clone.push(task)
          end
        end
        tasks = tasks_clone
      end
    end
    @tasks = Kaminari.paginate_array(tasks).page(params[:page]).per(PER)
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
    @task = Task.find(params[:id])
  end
  def task_params
    params.require(:task).permit(
                                :name,
                                :content,
                                :deadline,
                                :status,
                                :priority,
                                label_ids: []
                              )
  end
  def prohibit_other_user
    if current_user.id != @task.user.id
      redirect_to tasks_path
    end
  end
end
