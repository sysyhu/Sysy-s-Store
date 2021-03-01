class ProductImage < ApplicationRecord

	#associations
	belongs_to :product

	#validations, gem peperclip 提供的方法
	has_attached_file :image, styles: {
    small: '60^x60', 
    middle: '200^x200',
    big: "960x"
  }
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
  validates_attachment_size :image, in: 0..5.megabytes


end
