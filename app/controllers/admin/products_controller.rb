class Admin::ProductsController < Admin::BaseController

	before_action :find_product, only: [:edit, :update, :destroy]

  def index
  	@products = Product.page(params[:page] || 1).per_page(params[:per_page] || 10).order(id: "desc")
  end

  def new
  	@product = Product.new
  	@root_categories = Category.roots
  end

  def create
  	@product = Product.new(product_attr)
  	@root_categories = Category.roots
  	if @product.save
  		flash[:notice] = "商品创建成功"
  		redirect_to admin_products_path
  	else
  		flash[:notice] = "商品创建失败，请重试"
  		render action: :new
  	end	
  end

  def edit
  	@root_categories = Category.roots
  	render action: :new
  end

  def update
  	@product.update_attributes product_attr
  	@root_categories = Category.roots
  	if @product.save
  		flash[:notice] = "商品修改成功"
  		redirect_to admin_products_path
  	else
  		flash[:notice] = "商品修改失败，请重试"
  		render action: :new
  	end
  end

  def destroy	
  	if @product.destroy
  		flash[:notice] = "商品删除成功"
  		redirect_to admin_products_path
  	else
  		flash[:notice] = "商品删除失败，请重试"
  		redirect_back fallback_location: admin_products_path
  	end
  end

  private
  def product_attr
  	params.require(:product).permit!
  end

  def find_product
  	@product = Product.find(params[:id])
  end

end
