class Category < ApplicationRecord

	has_ancestry

	has_many :products, dependent: :destroy

	#validations
	validates :title, presence: { message: "名字不能为空"}

	before_validation :correct_ancestry

	private
	def correct_ancestry
		self.ancestry = nil if self.ancestry.blank?
	end



end
