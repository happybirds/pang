class Admin::SessionsController < Admin::Devise::SessionsController

  def resource_name
    :admin
  end

  def destroy
      sign_out(current_admin)
      respond_with_navigational(current_admin){ redirect_to after_sign_out_path_for(resource_name) }
  end

  private

  def after_sign_out_path_for(resource)
    new_admin_session_path
  end

  def after_sign_in_path_for(resource)
    admin_root_path
  end

end
