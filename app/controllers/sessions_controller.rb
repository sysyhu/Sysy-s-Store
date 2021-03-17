class SessionsController < ApplicationController

	helper_method :current_user
	helper_method :logged_in?

  def new
  end

  def create
  	@user = User.authenticate(params[:username], params[:password])

  	if @user 
  		login @user
      update_browser_uuid @user.uuid
  		flash[:notice] = "登录成功"
  		redirect_to root_path
  	else
  		flash[:notice] = "登录失败"
  		render action: :new
  	end
  end

  def destroy
  	logout
  	flash[:notice] = "退出成功"
  	redirect_to root_path
  end

  private
  #登录
  def login user 
  	session[:user_id] = user.id
  end

  #退出
  def logout
  	session[:user_id] = nil
  end

end
