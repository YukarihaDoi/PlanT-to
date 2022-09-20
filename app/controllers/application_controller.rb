class ApplicationController < ActionController::Base
before_action :configure_permitted_parameters, if: :devise_controller?

  # サインイン後の遷移先
  def after_sign_in_path_for(resource)
    if user_signed_in?
      post_images_path
    else
      admin_post_images_path
    end
  end
  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name,:prefecture]) #天気追加
  end
end
