class CarouselsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_carousel, only: [:show, :edit, :update, :destroy, :delete, :set_weight, :set_reveal]
  before_action :set_carousels, only: [:index, :set_weight, :set_reveal]
  before_action :set_left_bar
  access carousel: :all, message: "当前用户无权访问"

  # GET /carousels
  def index
  end

  def set_reveal
    @carousel.toggle!(:reveal)
    respond_to do |format|
      format.js do
      end
    end
  end

  def set_weight
    @carousel.update(weight: Time.now)
    respond_to do |format|
      format.js do
      end
    end
  end

  # GET /carousels/1
  def show
  end

  # GET /carousels/new
  def new
    @carousel = current_user.carousels.new
  end

  # GET /carousels/1/edit
  def edit
  end

  # POST /carousels
  def create
    @carousel = current_user.carousels.new(carousel_params)

    if @carousel.save
      flash[:success] = "创建成功"
      redirect_to carousels_path
    else
      render :new
    end
  end

  # PATCH/PUT /carousels/1
  def update
    if @carousel.update(carousel_params)
      flash[:success] = "更新成功"
      redirect_to carousels_path
    else
      render :edit
    end
  end


  def delete
  end

  # DELETE /carousels/1
  def destroy
    @carousel.destroy
    flash[:success] = "删除成功"
    redirect_to carousels_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_carousel
      @carousel = current_user.carousels.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def carousel_params
      params.require(:carousel).permit(:name, :is_name, :is_introduction, :attach, :introduction)
    end

    def set_carousels
      @carousels = current_user.carousels.page(params[:page])
    end

    def set_left_bar
      @available_roles = current_user.roles.reject{ |role| (role == :user) || (role == :root_admin) }.map(&:to_s)
      @options = current_user.options.where(name: @available_roles).where(reveal: true).order(:position)
    end
end
