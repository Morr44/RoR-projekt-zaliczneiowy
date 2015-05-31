class RegistrationsController < Devise::RegistrationsController
  skip_before_action :require_no_authentication, only: [:new, :create, :cancel]


  def create
    build_resource(sign_up_params)

    resource_saved = resource.save
    yield resource if block_given?
    if resource_saved
      if resource.active_for_authentication?
        
        sign_up(resource_name, resource)
        
        if params.has_key?(:project_id)
          @project = Project.find(params[:project_id])
          respond_with resource, location: @project
        else
          set_flash_message :notice, :signed_up if is_flashing_format?
          respond_with resource, location: after_sign_up_path_for(resource)
        end
        
      else
        set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_flashing_format?
        expire_data_after_sign_in!
        respond_with resource, location: after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      @validatable = devise_mapping.validatable?
      if @validatable
        @minimum_password_length = resource_class.password_length.min
      end
      if params.has_key?(:project_id)
        @project = Project.find(params[:project_id])
        respond_with resource
      else
        respond_with resource
      end
    end
  end




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
