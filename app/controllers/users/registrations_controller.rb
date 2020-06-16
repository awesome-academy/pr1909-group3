class Users::RegistrationsController < Devise::RegistrationsController
  def new
    build_resource
    yield resource if block_given?
  end

  def create
    build_resource(user_params)
    resource.save
    yield resource if block_given?
    if resource.persisted?
      if resource.active_for_authentication?
        sign_up(resource_name, resource)
        flash[:success] = t ".welcome"
        redirect_ajax root_path
      else
        set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
        expire_data_after_sign_in!
        redirect_ajax root_path
      end
    else
      respond_to do |format|
        format.js
      end
    end
  end

  private

  def user_params
    params.require(:user).permit :name, :email, :phone, :address, :password, :password_confirmation, :role_id
  end
end
