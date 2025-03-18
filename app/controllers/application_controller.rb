class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [ :name, :phone_number, :avatar ])
    devise_parameter_sanitizer.permit(:account_update, keys: [ :name, :phone_number, :avatar ])
  end

  private

  # https://stackoverflow.com/questions/6738966/how-do-i-update-a-user-attribute-after-signing-in-and-signing-out-with-devise-ge

  Warden::Manager.after_authentication do |user, auth, opts|
    user.update_attribute(:status, :online)
  end

  Warden::Manager.before_logout do |user, auth, opts|
    user.update_attribute(:status, :offline)
  end
end
