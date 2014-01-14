class ApplicationController < ActionController::Base
  protect_from_forgery

  respond_to :html, :json

  before_filter :update_sanitized_params, if: :devise_controller?
  helper_method :current_user_json

  def current_user_json
    if current_user
      UserSerializer.new(current_user, scope: current_user, root: false).to_json
    else
      {}.to_json
    end
  end

  def update_sanitized_params
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:email, :password, :password_confirmation) }
  end
end
