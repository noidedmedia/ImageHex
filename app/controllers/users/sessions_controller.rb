class Users::SessionsController < Devise::SessionsController
  prepend_before_filter :two_factor_enabled?, only: :create
  # before_filter :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  def create
    if params[:user][:otp_attempt]
      self.resource = User.find(params[:user][:id])
      unless resource.validate_and_consume_otp!(params[:user][:otp_attempt])
        flash[:alert] = "Invalid Authentication Token"
        render :two_factor
      else
        set_flash_message(:notice, :signed_in) if is_flashing_format?
        sign_in(resource_name, resource)
        yield resource if block_given?
        respond_with resource, location: after_sign_in_path_for(resource)
      end
    else
      self.resource = warden.authenticate!(auth_options)
      set_flash_message(:notice, :signed_in) if is_flashing_format?
      sign_in(resource_name, resource)
      yield resource if block_given?
      respond_with resource, location: after_sign_in_path_for(resource)
    end
  end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  protected
  
  def two_factor_enabled?
    @user = User.find_by(email: params[:user][:email])
    unless params[:user][:otp_attempt].present?
      if @user && @user.valid_password?(params[:user][:password])
        self.resource = @user
        render :two_factor if resource.otp_required_for_login
      else
        warden.authenticate!(auth_options)
      end
    end
  end
  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.for(:sign_in) << :attribute
  # end
end
