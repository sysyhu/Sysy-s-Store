class Admin::CategoriesController < Admin::BaseController

	before_action :find_root_categories, only: [:new, :create, :edit, :update]
	before_action :find_category, only: [:edit, :update, :destroy]

  def new
  	@category = Category.new
  	find_root_categories
  end

  def create
  	@category = Category.new(category_attr)
  	find_root_categories
  	if @category.save
  		flash[:notice] = "创建成功"
  		redirect_to admin_categories_path
  	else
  		flash[:notice] = "创建失败，请重试"
  		render action: :new
  	end
  end

  def index
  	if params[:id].blank?
  		@categories = Category.roots
  	else
  		@category = Category.find(params[:id])
  		@categories = @category.children
  	end

  	@categories = @categories.page(params[:page] || 1).per_page(params[:per_page] || 10).order(id: "desc")
  end

  def edit
  	find_category
  	find_root_categories
  	render action: :new
  end

  def update
  	find_category
  	find_root_categories
  	@category.update_attributes category_attr
  	if @category.save
  		flash[:notice] = "修改成功"
  		redirect_to admin_categories_path
  	else
  		flash[:notice] = "修改失败，请重试"
  		render action: :new
  	end
  end

  def destroy
  	find_category
  	if @category.destroy
  		flash[:notice] = "删除成功"
  		redirect_to admin_categories_path
  	else
  		flash[:notice] = "删除失败，请重试"
  		redirect_to :back
  	end
  end

  private
  def category_attr
  	params.require(:category).permit!
  end

  def find_root_categories
  	@root_categories = Category.roots.order(id: "desc")
  end

  def find_category
  	@category = Category.find(params[:id])
  end
end









