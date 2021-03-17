class User < ApplicationRecord
  authenticates_with_sorcery!
	
	#一、validations
	#username
	validates :username, presence: {message: "用户名不能为空"}
	validates :username, uniqueness: {message: "该用户名已被注册，请重试"}

	#email
	validates :email, presence: {message: "邮箱不能为空"}
	validates :email, format: {with: /\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*/, message: "请输入合法邮箱格式"}
	validates :email, uniqueness: {message: "该邮箱已被注册，请重试"}

	#password
	attr_accessor :password, :password_confrimation
	validates :password, presence: {message: "密码不能为空"}
	validates :password, length: {minimum: 6, message: "密码至少6位"}
	validates :password, confirmation: {message: "密码不一致"}
	validates :password_confirmation, presence: {message: "确认密码不能为空"}

	#二、associations
	has_many :addresses, -> { where(address_type: Address::AddressType::User) }
	belongs_to :default_address, class_name: :Address

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
  #设置加密密码
  def set_password
  	self.salt = self.object_id.to_s + rand.to_s
    self.crypted_password = Digest::SHA1.hexdigest(self.password + self.salt)
  end



end
