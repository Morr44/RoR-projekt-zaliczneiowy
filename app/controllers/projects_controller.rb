class ProjectsController < ApplicationController
  
  def index
    if params[:private] == "true"
      @projects = current_user.projects.paginate(:page => params[:page], :per_page => 10)
      
    else
      @projects = Project.paginate(:page => params[:page], :per_page => 10)
    end
    
  end


  def show
    @project = Project.find(params[:id])
    
  end

  def new
     @project = Project.new
  end
  
  def edit 
    if check_if_owner
      @project = Project.find(params[:id])
    else
      redirect_to @project
    end
    
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
    
    if check_if_owner
      @project = Project.find(params[:id])
      @project.destroy
      redirect_to projects_path
    else
      redirect_to @project
    end
  end

  
  def change_owner
    if check_if_owner
      @project = Project.find(params[:id])
      unless (params[:project][:owner_id]) == nil
        @project.update(project_params)
      end
      redirect_to @project
    else
      redirect_to @project
    end
  end
  
  def new_associate
    if check_if_owner
      @project = Project.find(params[:id])
    end
  end
  
  
  def invite
    @project = Project.find(params[:id])
    if check_if_owner
      @user = User.where(:email => params[:email]).first
      @project.add_associate(@user)
      redirect_to @project
    else
      redirect_to @project
    end
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
    if check_if_owner
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
    else
      redirect_to @project
    end
    
  end
  
  
  def index_tickets
    @statuses = Ticket.statuses
    @tickets = Ticket.where(:user_id => current_user.email)
  end



  private
    def project_params
      params.require(:project).permit(:name, :description, :owner_id)
    end
    
    
    def check_if_owner
      @project = Project.find(params[:id])
      unless @project.owner == current_user
        false
      else
        true
      end
      
    end


  
end