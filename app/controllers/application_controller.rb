class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user, :current_role

  #en cada controlador implementar
  #before_filter :degraded?
  before_filter :redirect_if_degraded
  around_filter :degrade 
  helper_method :rollout?

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


def degrade 
  degrade_feature(action_id) { yield }
end
def redirect_if_degraded
  render "errors/overload" if rollout?(action_id)
end

def rollout?(name)
  Rollout.overloaded? name
end

def degrade_feature(name)
  yield
rescue StandardError => e
  Rollout.mark name
  raise e
end

def action_id
  #raise current_controller_name + current_action
  current_controller_name + current_action
end

def current_action
  params["action"]
end

def current_controller_name
  params["controller"]
end

end
