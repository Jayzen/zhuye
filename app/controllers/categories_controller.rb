class CategoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_category, only: [:show, :edit, :update, :destroy, :delete, :set_weight, :set_reveal]
  before_action :set_categories, only: [:index, :set_weight, :set_reveal]
  before_action :set_left_bar
  access category: :all, message: "当前用户无权访问"

  # GET /categories
  def index
  end

  def set_reveal
    @category.toggle!(:reveal)
    respond_to do |format|
      format.js do
      end
    end
  end

  def set_weight
    @category.update(weight: Time.now)
    respond_to do |format|
      format.js do
      end
    end
  end

  # GET /categories/1
  def show
  end

  # GET /categories/new
  def new
    @category = current_user.categories.new
  end

  # GET /categories/1/edit
  def edit
  end

  # POST /categories
  def create
    @category = current_user.categories.new(category_params)

    if @category.save
      flash[:success] = "创建成功"
      redirect_to categories_path
    else
      render :new
    end
  end

  # PATCH/PUT /categories/1
  def update
    if @category.update(category_params)
      flash[:success] = "更新成功"
      redirect_to categories_path
    else
      render :edit
    end
  end


  def delete
  end

  # DELETE /categories/1
  def destroy
    @category.destroy
    flash[:success] = "删除成功"
    redirect_to categories_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = current_user.categories.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def category_params
      params.require(:category).permit(:name)
    end

    def set_categories
      @categories = current_user.categories.page(params[:page])
    end

    def set_left_bar
      @available_roles = current_user.roles.reject{ |role| (role == :user) || (role == :root_admin) }.map(&:to_s)
      @options = current_user.options.where(name: @available_roles).where(reveal: true).order(:position)
    end
end
