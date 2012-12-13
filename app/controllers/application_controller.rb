class ApplicationController < ActionController::Base
  check_authorization
  protect_from_forgery

  helper_method :current_user, :current_role, :current_user_country, :current_user_area
  helper_method :remove_cache
  skip_before_filter :verify_authenticity_token, :only => [:update,:create, :overload]

  #en cada controlador implementar
  #before_filter :degraded?
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, :alert => "No tienes los permisos necesarios"
  end
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
  def current_user_country
    unless current_user.blank?
      current_user.country
    else
      ""
    end
  end
  def current_user_area
    unless current_user.blank?
      current_user.area
    else
      ""
    end
  end

def degrade 
  if degradable?
    degrade_feature(action_id) { yield } 
  else
    yield
  end
end
def degradable?
  if production?
    action_id != "fetch_and_store"
  else
    false
  end
end
def redirect_if_degraded
  remove_cache if production? 
  render "errors/overload" if production? and rollout?(action_id) 
end

def rollout?(name)
  #Rollout.overloaded? name 
  production? ? RedisRollout.overloaded?(name) : false
end

def degrade_feature(name)
  yield
  rescue StandardError => e
  #Rollout.mark name
  RedisRollout.mark name if production?
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

def production?
  @prod ||= (Rails.env == "staging" || heroku_prod?) #|| Rails.env == "production" || Rails.env == "development" 
end
def heroku_prod?
  Rails.env == "heroku_production"
end
def remove_cache
  expire_page "/"
  expire_page "/articles"
end

end
