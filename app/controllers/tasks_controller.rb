class TasksController < ApplicationController
  def index
    #task_modelから全タスクデータを取得
    @tasks = Task.all
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.create(task_params)
    redirect_to @task
  end

  def show
    @task = Task.find(params[:id])
    @show_title = "タスク詳細"
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    # binding.pry
    #editページから送信されたparams(title,body)に変換
    @task = Task.update(task_params)
    redirect_to root_path

  end


  def delete
    @task.delete
    redirect_to root_path
  end

  
  private
  def task_params
    params.require(:task).permit(:title, :body)
  end
end
