class ApplicationController < ActionController::Base
	before_action :configure_permitted_parameters, if: :devise_controller?

	private

	def authenticate_user!
		if user_signed_in?
			super
		else
			redirect_to new_user_registration_path
		end
	end

	def after_sing_in_path_for(user)
		user_posts_path(user)
	end

	protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :password, :username])
    devise_parameter_sanitizer.permit(:sign_in, keys: [:email, :password, :username])
    devise_parameter_sanitizer.permit(:account_update, keys: [:email, :password, :username])
  end
end
