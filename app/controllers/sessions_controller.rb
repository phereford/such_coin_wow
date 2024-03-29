class SessionsController < Devise::SessionsController
  def create
    params[:user].merge!(remember_me: true)
    super
  end

  def destroy
    signed_out = Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name)

    render json: {
      'csrf-param' => request_forgery_protection_token,
      'csrf-token' => form_authenticity_token
    }
  end
end
