class Category < ApplicationRecord

	has_ancestry orphan_strategy: :destroy

	has_many :products, dependent: :destroy

	#validations
	validates :title, presence: { message: "分类名称不能为空"}
	# validates :title, uniquenss: { message: "该分类名称已存在"}

	before_validation :correct_ancestry

	def self.grouped_data
    self.roots.order("weight desc").inject([]) do |result, parent|
      row = []
      row << parent
      row << parent.children.order("weight desc")
      result << row
    end
  end

	private
	def correct_ancestry
		self.ancestry = nil if self.ancestry.blank?
	end



end
