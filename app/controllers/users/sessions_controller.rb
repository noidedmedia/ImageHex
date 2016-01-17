class Users::SessionsController < Devise::SessionsController
  prepend_before_action :two_factor_enabled?, only: :create
  # before_filter :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # FIXME HACK WTF: This is disgusting.
  def create
    if params[:user][:otp_attempt] && params[:user][:otp_attempt] != ""
      self.resource = User.find(params[:user][:id])
      # Somebody's trying to attack us. Foil it.
      render_weirdness! if resource.id != session[:_otp_password_id]

      unless resource.validate_and_consume_otp!(params[:user][:otp_attempt])
        flash[:alert] = I18n.t("notices.invalid_two_factor_authentication_code")
        render :two_factor
      else
        set_flash_message(:notice, :signed_in) if is_flashing_format?
        sign_in(resource_name, resource)
        yield resource if block_given?
        respond_with resource, location: after_sign_in_path_for(resource)
      end
    elsif params[:user][:otp_backup_attempt] && params[:user][:otp_backup_attempt] != ""
      self.resource = User.find(params[:user][:id])
      # Prevent hackzors
      render_weirdness! if resource.id != session[:_otp_password_id]
      if resource.invalidate_otp_backup_code!(params[:user][:otp_backup_attempt])
        resource.save
        set_flash_message(:notice, :signed_in) if is_flashing_format?
        sign_in(resource_name, resource)
        yield resource if block_given?
        respond_with resource, location: after_sign_in_path_for(resource)
      else
        flash[:alert] = I18n.t("notices.invalid_two_factor_authentication_backup_code")
        render :two_factor
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
    unless params[:user][:otp_attempt].present? || params[:user][:otp_backup_attempt].present?
      if @user && @user.valid_password?(params[:user][:password])
        self.resource = @user
        if resource.otp_required_for_login
          session[:_otp_password_id] = @user.id
          render :two_factor
        end
      else
        warden.authenticate!(auth_options)
      end
    end
  end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.for(:sign_in) << :attribute
  # end
  def render_weirdness!
    render plain: "Something weird happened, or you were trying to hack us"
  end
end
