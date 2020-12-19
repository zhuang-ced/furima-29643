class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

def create
  User.create(user_params)
end


  private
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(
      :sign_up, keys: [:nickname, :email, :encrypted_password, :first_name, :last_name, :lastname_kana, :firstname_kana, :birthday])
  end

end
