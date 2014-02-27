class Users::RegistrationsController < Devise::RegistrationsController

  def after_destroy_path_for(resource)
    
    root_path(resource)
  end

end