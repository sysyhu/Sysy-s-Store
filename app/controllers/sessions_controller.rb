class SessionsController < ApplicationController
  def new
  end

  def create
  	@user = User.authenticate(params[:username], params[:password])
  	if @user 
  		session[:user_id] = @user.id
  		flash[:notice] = "登录成功"
  		redirect_to root_path
  	else
  		flash[:notice] = "登录失败"
  		render action: :new
  	end
  end

  def destroy

  end
end
