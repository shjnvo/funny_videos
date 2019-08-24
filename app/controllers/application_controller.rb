class ApplicationController < ActionController::Base
  helper_method :current_user

  def login(user)
    session[:user_id] = user.id
    @current_user = user
    flash[:notice] = 'Logged!!'
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def authenticate_user
    return true if current_user

    redirect_to root_path
  end
end
