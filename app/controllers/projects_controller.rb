class ProjectsController < ApplicationController
  
  def index
    @projects = Project.all
  end

  def show
    @project = Project.find(params[:id])
    
  end

  def new
     @project = Project.new
  end
  
  def edit
    @project = Project.find(params[:id])
  end
  
  def update
    @project = Project.find(params[:id])
    
    if @project.update(project_params)
      redirect_to @project
    else
      render 'edit'
    end
    
  end
  
  def destroy
    @project = Project.find(params[:id])
    @project.destroy
    redirect_to projects_path
    
  end
  
  def create
    @project = Project.new(project_params)
    @project.add_associate current_user
    @project.set_owner current_user
    
    if @project.save
      redirect_to @project
    else
      render 'new'
    end
    
  end

  def new_associate
    @project = Project.find(params[:id])
  end

  private
    def project_params
      params.require(:project).permit(:name, :description)
    end
    
    
  
end