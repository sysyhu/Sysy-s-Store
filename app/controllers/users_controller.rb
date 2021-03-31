class UsersController < ApplicationController

  #Controller 开发: 1. 收集处理用户数据; 2. 交给数据库审核员验证, 储存; 3. 回应用户

  def index
  end

  def new
  	@user = User.new
  end

  def create
  	@user = User.new(user_attr)#1. 收集(params)处理(实例化 @user)用户数据
    @user.uuid = session[:user_uuid]
  	if @user.save #2. 交给数据库审核员验证, 储存
  		flash[:notice] = "注册成功，请登录" #3. 回应用户
  		redirect_to new_session_path
  	else
  		flash[:notice] = "注册失败，请再试一次" #3. 回应用户
  		render action: :new
  	end
  end

  def show #!!!如何收集用户数据 id 的？A: URL 带过来的
    @user = User.find(params[:id])#1. 收集（parmas)处理(实例化 @user)用户数据
    #3. rails 自动回应用户，show.html.erb
  end

  def edit
    @user = User.find(params[:id])#1. 收集（params）处理（实例化 @user）用户数据
    render action: :new #3. 回应用户
  end

  def update #!!!为什么退出后修改前后的 username、email 都不能登录了？
    @user = User.find(params[:id]) #1. 收集（params）处理（实例化 @user）用户数据
    @user.update_attributes(user_attr) #1. 收集（params）处理（update_attributs）用户数据
    if @user.save #2. 交给数据库审核员验证, 储存
      flash[:notice] = "修改成功" #3. 回应用户
      redirect_to user_path(@user) #3. 回应用户
    else
      flash[:notice] = "修改失败，请再试一次" #3. 回应用户
      render action: :new #3. 回应用户
    end
  end

  private
  def user_attr #收集用户数据
  	params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end
end
