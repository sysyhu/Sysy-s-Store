module SessionsHelper
	def logged_in?
  	!session[:user_id].nil?
  end

  def current_user
  	if logged_in?
  		@current_user ||= User.find(session[:user_id])
  	else
  		nil
  	end
  end
end
