class RegistrationsController < Devise::RegistrationsController
  skip_before_action :require_no_authentication, only: [:new, :create, :cancel]

  protected

  def sign_up(resource_name, resource)
      
    unless params.has_key?(:project_id)
        sign_in(resource_name, resource)
    else
       @project = Project.find(params[:project_id])
       @project.add_associate self.resource
        
    end
    
    
  end
end
