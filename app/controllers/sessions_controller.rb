class SessionsController < ApplicationController

	helper_method :current_user
	helper_method :logged_in?

  def new
  end

  def create
  	@user = User.authenticate(params[:username], params[:password]) #1. 收集（params）处理（user model 里的类方法）用户数据

  	if @user 
  		login @user #1. 处理数据
      update_browser_uuid @user.uuid #!!!为什么要这个
  		flash[:notice] = "登录成功" #3. 回应用户
  		redirect_to root_path 
  	else
  		flash[:notice] = "用户名或密码不正确，请再试一次" #3. 回应用户
  		render action: :new 
  	end
  end

  def destroy
  	logout #!!! session[:user_id] 怎么传过来的？
    cookies[:user_uuid] = nil
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
