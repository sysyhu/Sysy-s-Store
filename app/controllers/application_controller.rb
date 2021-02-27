class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user
  helper_method :logged_in?


  #是否登录？
  def logged_in?
    !session[:user_id].nil?
  end

  #当前用户
  def current_user
  	if logged_in?
  		@current_user ||= User.find(session[:user_id])
  	else
  		nil
  	end
  end

end
