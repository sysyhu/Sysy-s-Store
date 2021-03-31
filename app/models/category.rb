class Category < ApplicationRecord

  #模型开发 Step 1.
  #一、需要哪些数据入库？
  #title, weight, product_counter, ancestry

  #二、需要收集哪些数据, 如何收集？
  #title(form, 必填， 不重复), weight(form, 默认 0, 可不填), 
  #product_counter(通过 association 计算), ancestry(form, 默认第一级)


  #三、验证数据，哪些方面，条件？

  #四、数据处理, 回调。收集的数据 ≠ 要存的数据
  #!!!product_counter 什么时候更新的?

  #五、 save

  #模型开发 Step 2.
  #一、 关联关系
  #1. has_many :products
  #2. 有父级

	#一、validations
	validates :title, presence: { message: "分类名称不能为空"}
	#validates :title, uniquenss: { message: "该分类名称已存在"}

  #二、associations
  has_ancestry orphan_strategy: :destroy 
  #!!!gem ancestry, https://github.com/stefankroes/ancestry
  #!!!建立自身关联 g migration add_ancestry_to_categroy, add_colum :categories, :ancestry, :string
  #模型里配置 has_ancestry, gem 官方介绍里有步骤
  has_many :products, dependent: :destroy

  #三、callback
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
    #不然，提交数据的时候要报错，因为!!!不能保存空的字符串
	end



end
