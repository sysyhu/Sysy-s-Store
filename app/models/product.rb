class Product < ApplicationRecord

  #模型开发 Step 1.
  #一、需要哪些数据入库？
	#category_id, title, status, amount, uuid, msrp, price, description

  #二、需要收集哪些数据, 如何收集？
	#title(form, 必填，不重复), status(form, 默认'off'), amount(form, 必填), msrp/price/description(form, 必填)
	#!!!category_id 如何收集？

  #三、验证数据，哪些方面，条件？
	#category_id(presence) !!!
	#title(presence, uniqueness), amount(presence, >= 0, =0 时 status 为'off'), msrp/price/description(presence)

	#四、数据处理, 回调。收集的数据 ≠ 要存的数据
  #uuid, before_create :set_uuid, self.uuid = XXX

	#五、 save

  #模型开发 Step 2.
  #一、 关联关系
  #1. belongs_to :category

	#一、validations
	validates :category_id, presence: { message: "商品分类不能为空" }
	validates :title, presence: { message: "商品名称不能为空"}
	validates :title, uniqueness: { message: "该商品名称已存在，请重新输入"}
	validates :status, inclusion: { in: %w(off on), message: "商品状态必须为 on 或者 off" } #!!!inclusion?
	validates :amount, presence: { message: "商品库存不能为空"}
	validates :amount, numericality: { only_integer: true, message: "商品库存必须为整数" }, #!!!numericality
		if: proc { |product| !product.amount.blank? } #!!! >= 0 ?
	validates :msrp, presence: { message: "msrp 不能为空"}
	validates :msrp, numericality: { message: "msrp 必须为数字"},
		if: proc { |product| !product.msrp.blank? }
	validates :price, presence: { message: "商品价格不能为空"}
	validates :price, numericality: { message: "商品价格必须为数字"},
		if: proc { |product| !product.price.blank? }
	validates :description, presence: { message: "商品描述不能为空"}

  #二、associations
  belongs_to :category
  has_many :product_images, -> { order(weight: 'desc') }, dependent: :destroy
  has_one :main_product_image, -> { order(weight: 'desc') },
    class_name: :ProductImage

	#三、scope
  scope :onshelf, -> { where(status: Status::On) }

  #四、callback
  before_create :set_product_uuid

  #常量
	module Status
		On = 'on'
		Off = 'off'
	end

  #类方法

  #实例方法
	private
	def set_product_uuid
		self.uuid = RandomCode.generate_product_uuid 
    #!!!RandomCode lib 文件里，config-application.rb 里配置，才可调用
	end

end
