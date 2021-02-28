class Category < ApplicationRecord

	has_ancestry

	has_many :products, dependent: :destroy

	#validations
	validates :title, presence: { message: "名字不能为空"}



end
