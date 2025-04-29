class TasksController < ApplicationController
  before_action :authenticate_user, { only: %i[edit update status_update logout] }

  def index
    # task_modelから全タスクデータを取得
    @tasks = Task.all
    case params[:sort]
    when 'asc'
      Task.order(created_at: :asc)
    when 'desc'
      Task.order(created_at: :desc)
    end

    case params[:period]
    when 'week'
      @tasks = @tasks.where('created_at >= ?', 1.week.ago)
    when 'month'
      @tasks = @tasks.where('created_at >= ?', Time.current.beginning_of_month)
    end
  end

  def new
    @task = Task.new
  end

  def create
    @task = Current.user.tasks.build(task_params)
    if @task.save
      redirect_to root_path, notice: 'タスクを作成しました！'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @task = Task.find(params[:id])
    @show_title = 'タスク詳細'
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    # editページから送信されたparams(title,body)に変換
    @task = Task.where(id: params[:id]).update(task_params)
    redirect_to root_path
  end

  def destroy
    @task = Task.find(params[:id]).destroy
    redirect_to root_path, notice: 'タスクを削除しました！'
  end

  def status_update
    @task = Task.find(params[:id])
    @task.update(status: params[:status])
    redirect_to root_path, notice: '進捗を更新しました'
  end

  private

  def task_params
    params.require(:task).permit(:title, :body)
  end
end
