class Product < ApplicationRecord

	belongs_to :category

	before_create :set_default_attrs

	#validations
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


	private
	def set_default_attrs
		self.uuid = RandomCode.generate_product_uuid
	end

end
