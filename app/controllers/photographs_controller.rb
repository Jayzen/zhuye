class PhotographsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_photograph, only: [:show, :edit, :update, :destroy, :delete, :set_reveal, :set_weight]
  before_action :set_photographs, only: [:index, :set_reveal, :set_weight]
  before_action :set_left_bar
  access photograph: :all, message: "当前用户无权访问"

  # GET /photographs
  def index
  end

  def set_reveal
    @photograph.toggle!(:reveal)
    respond_to do |format|
      format.js do
      end
    end
  end

  def set_weight
    @photograph.update(weight: Time.now)
    respond_to do |format|
      format.js do
      end
    end
  end

  # GET /photographs/1
  def show
  end

  # GET /photographs/new
  def new
    @photograph = current_user.photographs.new
  end

  # GET /photographs/1/edit
  def edit
  end

  # POST /photographs
  def create
    @photograph = current_user.photographs.new(photograph_params)

    if @photograph.save
      flash[:success] = "创建成功"
      redirect_to photographs_path
    else
      render :new
    end
  end

  # PATCH/PUT /photographs/1
  def update
    if @photograph.update(photograph_params)
      flash[:success] = "更新成功"
      redirect_to photographs_path
    else
      render :edit
    end
  end

  def delete
  end

  # DELETE /photographs/1
  def destroy
    @photograph.destroy
    flash[:success] = "删除成功"
    redirect_to photographs_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_photograph
      @photograph = current_user.photographs.find(params[:id])
    end
    
    def set_photographs
      @photographs = current_user.photographs.page(params[:page])
    end
    
    def photograph_params
      params.require(:photograph).permit(:name, :image)
    end

    def set_left_bar
      @available_roles = current_user.roles.reject{ |role| (role == :user) || (role == :root_admin) }.map(&:to_s)
      @options = current_user.options.where(name: @available_roles).where(reveal: true).order(:position)
    end 
end
