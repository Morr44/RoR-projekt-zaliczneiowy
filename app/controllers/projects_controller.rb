class ProjectsController < ApplicationController
  
  def index
    if params[:private] == "true"
      @projects = current_user.projects
      
    else
      @projects = Project.all
    end
    
    
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

  def destroy
    @project = Project.find(params[:id])
    @project.destroy
    redirect_to projects_path
    
  end

  def new_associate
    @project = Project.find(params[:id])
  end
  
  def change_owner
    @project = Project.find(params[:id])
    unless (params[:project][:owner_id]) == nil
      @project.update(project_params)
    end
    redirect_to @project
    
  end
  
  def invite
    @project = Project.find(params[:id])
    @user = User.where(:email => params[:email]).first
    @project.add_associate(@user)
    redirect_to @project
    
  end
  
  def quit
    @project = Project.find(params[:id])
    @project.remove_associate current_user
    
    @project.tickets.each { |t|
      if t.user_id == current_user.email
        t.update_attributes(:user_id => nil)
      end
    }
    
    @project.update_attributes(:users => @project.users)
    redirect_to projects_path
    
  end
  
  def force_quit
    
    @project = Project.find(params[:id])
    @user = User.find(params[:project][:users])
    @project.remove_associate @user
    
    @project.tickets.each { |t|
      if t.user_id == @user.email
        t.update_attributes(:user_id => nil)
      end
    }
    
    @project.update_attributes(:users => @project.users)
    redirect_to @project
    
  end
  
  
  def index_tickets
    @statuses = Ticket.statuses
    @tickets = Ticket.where(:user_id => current_user.email)
  end



  private
    def project_params
      params.require(:project).permit(:name, :description, :owner_id)
    end
    
    
  
end