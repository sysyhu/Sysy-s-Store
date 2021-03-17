class Product < ApplicationRecord

	#一、validations
	validates :category_id, presence: { message: "商品分类不能为空" }
	validates :title, presence: { message: "商品名称不能为空"}
	validates :title, uniqueness: { message: "该商品名称已存在，请重新输入"}
	validates :status, inclusion: { in: %w(off on), message: "商品状态必须为 on 或者 off" }
	validates :amount, presence: { message: "商品库存不能为空"}
	validates :amount, numericality: { only_integer: true, message: "商品库存必须为整数" },
		if: proc { |product| !product.amount.blank? }
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
  before_create :set_default_attrs

  #常量
	module Status
		On = 'on'
		Off = 'off'
	end

  #类方法

  #实例方法
	private
	def set_default_attrs
		self.uuid = RandomCode.generate_product_uuid
	end

end
