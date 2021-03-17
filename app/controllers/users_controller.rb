class UsersController < ApplicationController
  def index
  end

  def new
  	@user = User.new
  end

  def create
  	@user = User.new(user_attr)
    @user.uuid = session[:user_uuid]
  	if @user.save
  		flash[:notice] = "注册成功，请登录"
  		redirect_to new_session_path
  	else
  		flash[:notice] = "注册失败，请再试一次"
  		render action: :new
  	end
  end

  private
  def user_attr
  	params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end
end
