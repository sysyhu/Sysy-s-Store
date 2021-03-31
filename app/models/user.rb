class User < ApplicationRecord
  authenticates_with_sorcery!

  #模型开发 Step 1.
  #一、需要哪些数据入库？
  #A: 第一轮: username, email, salt, crypted_password

  #二、需要收集哪些数据, 如何收集？
  #A: username, email, password, password_confirmation

  #三、验证数据，哪些方面，条件？
  #1. 收集来的每个数据验证哪些方面？presence, uniqueness...
  #A: username: presence, uniqueness; email: prensence, uniqueness, format; password: length, presence; password_confirmation: presence, confirmation
  #2. 触发验证的方法？
  #A: create, save, update 和带 ! 的
  #3. 什么情况下需要验证？

  #四、数据处理, 回调。收集的数据 ≠ 要存的数据

  #五、save

  #模型开发 Step 2.
  #一、 关联关系
  
	
	#一、validations
	#username
	validates :username, presence: {message: "用户名不能为空"}
	validates :username, uniqueness: {message: "该用户名已被注册，请重试"}

	#email
	validates :email, presence: {message: "邮箱不能为空"}
	validates :email, format: {with: /\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*/, message: "请输入合法邮箱格式", 
      if: Proc.new { |user| !user.email.blank? }} #!!!Proc.new 跟之前版本不一样
	validates :email, uniqueness: {message: "该邮箱已被注册，请重试"}

	#password
	attr_accessor :password, :password_confirmation
	validates :password, presence: {message: "密码不能为空"}, 
    if: :need_validate_password
	validates :password, length: {minimum: 6, message: "密码至少6位"},
    if: :need_validate_password, unless: Proc.new { |user| user.password.blank? }
	validates :password, confirmation: {message: "密码不一致"},
    if: :need_validate_password, unless: Proc.new { |user| user.password_confirmation.blank? or user.password.blank? }
	validates :password_confirmation, presence: {message: "确认密码不能为空"},
    if: :need_validate_password, unless: Proc.new { |user| user.password.blank? }

	#二、associations
  has_many :addresses, -> { where(address_type: Address::AddressType::User).order("id desc") }
  belongs_to :default_address, class_name: :Address
  has_many :orders

  #三、scope

  #四、callback
  before_create :set_password

  #五、常量

  #六、类方法
	#用户登录验证
	def self.authenticate(username, password)
		user = User.find_by(username: username)
		if user and user.valid_password?(password)
			user
		else
			nil
		end
	end

	def valid_password? password
    self.crypted_password == Digest::SHA1.hexdigest(password + self.salt)
  end


	private
  #用户在创建、修改密码的时候，需验证 password 和 password_confirmation
  def need_validate_password #!!!为什么只有password，password_confirmation 需要？email不需要
    self.new_record? || (!self.password.nil? || !self.password_confirmation.nil?)
  end

  #设置加密密码
  def set_password
  	self.salt = self.object_id.to_s + rand.to_s
    self.crypted_password = Digest::SHA1.hexdigest(self.password + self.salt)
  end



end
