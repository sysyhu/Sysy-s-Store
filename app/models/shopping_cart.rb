class ShoppingCart < ApplicationRecord

  #一、validations
  validates :user_uuid, presence: true
  validates :product_id, presence: true
  validates :amount, presence: true

  #二、associations
  belongs_to :product

  #三、scope
  scope :by_user_uuid, -> (user_uuid) { where(user_uuid: user_uuid) }

  #四、callback


  #类方法
  def self.create_or_update! options = {}
     cond = {
      user_uuid: options[:user_uuid],
      product_id: options[:product_id]
     }

     record = where(cond).first
     if record
      record.update_attributes!(options.merge(amount: record.amount + options[:amount]))
     else
      record = create!(options)
     end

     record
  end
end
