class TasksController < ApplicationController
    before_action :require_user_logged_in
    before_action :set_task , only:[:show, :edit, :update, :destroy]
    
    def index
        @tasks = Task.order(id: :desc).page(params[:page]).per(25)
    end
    
    def show
    end
    
    def new
        @task = Task.new
    end
    
    def create
        @task = Task.new(task_params)
        
        if @task.save
            flash[:success] = "新規タスクを追加しました"
            redirect_to @task
        else
            flash.now[:danger] = "新規タスクを追加できませんでした"
            render :new
        end
    end
    
    def edit
    end
    
    def update
        if @task.update(task_params)
            flash[:success] = "id:#{@task.id}のタスクを更新しました"
            redirect_to @task
        else
            flash[:danger] = "id:#{@task.id}のタスクを更新できませんでした"
            render :edit
        end
    end
    
    def destroy
        @task.destroy
        
        flash[:success] = "id:#{@task.id}のタスクを削除しました"
        redirect_to root_url
    end
    
    private
    
    def task_params
        params.require(:task).permit(:content, :status)
    end
    
    def set_task
        @task = Task.find(params[:id])
    end
    
end
