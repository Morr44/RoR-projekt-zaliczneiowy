class TicketsController < ApplicationController
    
    before_filter :check_if_developer
    
    def check_if_developer
        @project = Project.find(params[:project_id])
        unless @project.users.include?(current_user)
            redirect_to project_path(params[:project_id])
        end
    end
    
    
    def index
        @statuses = Ticket.statuses
        @project = Project.find(params[:project_id])
        @tickets = @project.tickets
       

    end
    
    def show
        @statuses = Ticket.statuses
        @project = Project.find(params[:project_id])
        @ticket = @project.tickets.find(params[:id])
        @ticket.update_attributes(:reported => true)
        
    end
    
    def new
        @statuses = Ticket.statuses
        @project = Project.find(params[:project_id])
        @ticket = Ticket.new
        
    end
    
    def create
        @statuses = Ticket.statuses
        @project = Project.find(params[:project_id])
        @ticket = @project.tickets.create(ticket_params)
        
        unless params[:ticket][:attachment] != nil
          @ticket.attachment_name = nil
        end
        
        if @ticket.save
            redirect_to  project_tickets_path
        else 
            render 'new'
        end
        @ticket.update_attributes(:reported => false)

        
    end
    
    def edit
        @statuses = Ticket.statuses
        @project = Project.find(params[:project_id])
        @ticket = @project.tickets.find(params[:id])
        
    end
    
    def update
        @statuses = Ticket.statuses
        @project = Project.find(params[:project_id])
        @ticket = @project.tickets.find(params[:id])
        
        unless params[:ticket][:user_id]==nil or @ticket.user_id == params[:ticket][:user_id]
            params[:ticket][:reported] = false
        end
        
        unless params[:ticket][:attach]=="1"
            @ticket.delete_attachment
            params[:ticket][:attachment_name] = nil 
        else
            unless @ticket.attachment.exists? or params[:ticket][:attachment] != nil
               params[:ticket][:attachment_name] = nil 
            end
        end
        
        if @ticket.update(ticket_params)
            redirect_to  project_tickets_path
        else 
            render 'edit'
        end
        


    end
    
    def destroy
        @project = Project.find(params[:project_id])
        @ticket = @project.tickets.find(params[:id])
        @ticket.destroy
        redirect_to project_tickets_path
        
    end
    
    
    private
        def ticket_params
            params.require(:ticket).permit(:title, :description, :priority, :estimation, :status, :attachment, :attachment_name, :user_id, :reported)
        end
end
