class User < ApplicationRecord
	attr_accessor :password, :password_confrimation

	#validations
	validates :username, presence: {message: "用户名不能为空"}
	validates :username, uniqueness: {message: "该用户名已被注册，请重试"}

	validates :email, presence: {message: "邮箱不能为空"}
	validates :email, format: {with: /\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*/, message: "请输入合法邮箱格式"}
	validates :email, uniqueness: {message: "该邮箱已被注册，请重试"}

	validates :password, presence: {message: "密码不能为空"}
	validates :password, length: {minimum: 6, message: "密码至少6位"}
	validates :password, confirmation: {message: "密码不一致"}
	validates :password_confirmation, presence: {message: "确认密码不能为空"}

	def password= (pwd)
		#不要这句话可以吗？
		@password = pwd 
		return if pwd.blank?
		create_new_salt
		#为什么后面要通过一个类方法加密?
		self.crypted_password = self.class.hashed_password(pwd, self.salt)
	end

	private
	def create_new_salt
    self.salt = self.object_id.to_s + rand.to_s
  end
  
  def self.hashed_password(password, salt)
    string_to_hash = password + "wibble" + salt
    Digest::SHA1.hexdigest(string_to_hash)
  end

end
