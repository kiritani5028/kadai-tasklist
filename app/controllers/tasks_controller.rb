class TasksController < ApplicationController
    
    def index
        @tasks = Task.all
    end
    
    def show
        @task = Task.find(params[:id])
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
        @task = Task.find(params[:id])
        
    end
    
    def update
        @task = Task.find(params[:id])
        
        if @task.update(task_params)
            flash[:success] = "id:#{@task.id}のタスクを更新しました"
            redirect_to @task
        else
            flash[:danger] = "id:#{@task.id}のタスクを更新できませんでした"
            render :edit
        end
    end
    
    def destroy
        @task = Task.find(params[:id])
        @task.destroy
        
        flash[:success] = "id:#{@task.id}のタスクを削除しました"
        redirect_to tasks_url
    end
    
    private
    
    def task_params
        params.require(:task).permit(:content)
    end
    
end
