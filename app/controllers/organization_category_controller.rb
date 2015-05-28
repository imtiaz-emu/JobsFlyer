class OrganizationCategoryController < ApplicationController
  before_action :authenticate_admin_user!
  before_action :set_category, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @categories = OrganizationCategory.all
    respond_with(@categories)
  end

  def show
    respond_with(@category)
  end

  def new
    @category = OrganizationCategory.new
    respond_with(@category)
  end

  def edit
  end

  def create
    @category = OrganizationCategory.new(category_params)
    @category.save
    respond_with(@category)
  end

  def update
    @category.update(category_params)
    respond_with(@category)
  end

  def destroy
    @category.destroy
    respond_with(@category)
  end

  private
  def set_category
    @category = OrganizationCategory.find(params[:id])
  end

  def category_params
    params.require(:organization_category).permit(:name)
  end

end
