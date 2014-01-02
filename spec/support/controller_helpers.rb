module ControllerHelpers
  def sign_in(user = double('user'))
    if user.nil?
      request.env['warden'].stub(:authenticate!).
        and_throw(:warden, {:scope => :user})
      controller.stub :current_user => nil
    else
      request.env['warden'].stub :authenticate! => user
      controller.stub :current_user => user
    end
  end

  def attributes_with_foreign_keys(*args)
    FactoryGirl.build(*args).attributes.delete_if do |k, v| 
      ["id", "type", "created_at", "updated_at"].member?(k)
    end
  end
end
