class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user
  helper_method :logged_in?

  before_action :set_browser_uuid

  
  protected

  def auth_user
    unless logged_in?
      flash[:notice] = "请登录"
      redirect_to new_session_path
    end
  end

  def fetch_home_data
    @categories = Category.grouped_data
    @shopping_cart_count = ShoppingCart.by_user_uuid(session[:user_uuid]).count
  end


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

  def set_browser_uuid
    # binding.pry
    uuid = cookies[:user_uuid]

    unless uuid.present?
      if logged_in?
        uuid = current_user.uuid
      else
        uuid = RandomCode.generate_utoken
      end
    end

    update_browser_uuid uuid
  end

  def update_browser_uuid uuid
    session[:user_uuid] = ( cookies.permanent['user_uuid'] = uuid )
  end

end












