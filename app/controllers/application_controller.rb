class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authenticate_user!

  respond_to :html, :json

  helper_method :current_user_json

  def current_user_json
    if current_user
      UserSerializer.new(current_user, scope: current_user, root: false).to_json.html_safe
    else
      {}.to_json
    end
  end
end
