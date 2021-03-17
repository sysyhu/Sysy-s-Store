class Address < ApplicationRecord
  #一、validations
  validates :user_id, presence: true
  validates :address_type, presence: true
  validates :contact_name, presence: { messages: "联系人姓名不能为空" }
  validates :cellphone, presence: { messages: "手机号码不能为空" }
  validates :address, presence: { messages: "收货地址不能为空" }

  #二、associations
  belongs_to :user

  module AddressType
    User = 'user'
    Order = 'order'
  end

end
