class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user, :current_role

  private
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  def current_user_id
  	if current_user
  		current_user.id
  	else
  		nil
  	end
  end
  def current_role
  	unless current_user.blank?
  		Ability.get_permissions(current_user.role)
  	else
  		User::ROLES[-1]
  	end
  end

end
