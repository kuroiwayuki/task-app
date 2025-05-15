class TasksController < ApplicationController
  before_action :authenticate_user, { only: %i[edit update status_update logout] }

  def index
    @tasks = Task.all

    # 並び替え
    case params[:sort]
    when 'asc'
      @tasks = @tasks.order(created_at: :asc)
    when 'desc'
      @tasks = @tasks.order(created_at: :desc)
    end

    # 期間フィルター（プリセット）
    case params[:period]
    when 'week'
      @tasks = @tasks.where('created_at >= ?', 1.week.ago)
    when 'month'
      @tasks = @tasks.where('created_at >= ?', Time.current.beginning_of_month)
    end

    if params[:created_at].present?
      begin
        date = Date.parse(params[:created_at])
      rescue ArgumentError
        date = nil
      end
      @tasks = @tasks.where(created_at: date.beginning_of_day..date.end_of_day) if date
    end
  end

  def new
    @task = Task.new
    render layout: false if turbo_frame_request?
  end

  def create
    @task = Current.user.tasks.build(task_params)

    if @task.save
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to tasks_path, notice: 'タスク作成成功' }
      end
    else
      puts @task.errors.full_messages
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace('modal', partial: 'shared/form', locals: { task: @task })
        end
        format.html do
          render :new, status: :unprocessable_entity
        end
      end
    end
  end

  def modal
    @task = Task.new
    render partial: 'tasks/modal', formats: [:html]
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
    @nowtask = @task[:status]
    @task.update(status: params[:status])
    if @nowtask === @task[:status]
      redirect_to root_path
    else
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to root_path, notice: '進捗を更新しました' }
      end
    end
  end

  private

  def task_params
    # ストロングパラメーターでカラム強制
    params.require(:task).permit(:title, :body)
  end
end
