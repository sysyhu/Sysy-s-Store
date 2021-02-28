class Admin::CategoriesController < Admin::BaseController
  def new
  	@category = Category.new
  	@root_categories = Category.roots.order(id: "desc")
  end

  def create
  	@category = Category.new(category_attr)
  	@root_categories = Category.roots.order(id: "desc")
  	if @category.save
  		flash[:notice] = "创建成功"
  		redirect_to admin_categories_path
  	else
  		flash[:notice] = "创建失败，请重试"
  		render action: :new
  	end
  end

  def index
  	@categories = Category.roots.page(params[:page] || 1).per_page(params[:per_page] || 10).order(id: "desc")
  end

  def update
  end

  def destroy
  end

  private
  def category_attr
  	params.require(:category).permit!
  end
end
