class DevicesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_device, only: [:rqrcode, :show, :edit, :update, :destroy, :delete, :set_weight, :set_reveal]
  before_action :set_devices, only: [:index, :set_weight, :set_reveal]
  before_action :set_left_bar
  before_action :set_categories, only: [:new, :edit]
  access device: :all, message: "当前用户无权访问"

  def rqrcode
    @qr = RQRCode::QRCode.new(device_url(@device), :size => 5, :level => :h )
  end
  
  # GET /devices
  def index
  end

  def set_reveal
    @device.toggle!(:reveal)
    respond_to do |format|
      format.js do
      end
    end
  end

  def set_weight
    @device.update(weight: Time.now)
    respond_to do |format|
      format.js do
      end
    end
  end

  # GET /devices/1
  def show
  end

  # GET /devices/new
  def new
    @device = current_user.devices.new
  end

  # GET /devices/1/edit
  def edit
  end

  # POST /devices
  def create
    @device = current_user.devices.new(device_params)

    if @device.save
      flash[:success] = "创建成功"
      redirect_to devices_path
    else
      render :new
    end
  end

  # PATCH/PUT /devices/1
  def update
    if @device.update(device_params)
      flash[:success] = "更新成功"
      redirect_to devices_path
    else
      render :edit
    end
  end


  def delete
  end

  # DELETE /devices/1
  def destroy
    @device.destroy
    flash[:success] = "删除成功"
    redirect_to devices_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_device
      @device = current_user.devices.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def device_params
      params.require(:device).permit(:name, :details, :category_id, :pic, :location, :status)
    end

    def set_devices
      @devices = current_user.devices.includes(:category).page(params[:page])
    end

    def set_left_bar
      @available_roles = current_user.roles.reject{ |role| (role == :user) || (role == :root_admin) }.map(&:to_s)
      @options = current_user.options.where(name: @available_roles).where(reveal: true).order(:position)
    end

    def set_categories
      @categories = current_user.categories.includes(:devices).where(reveal: true)
    end
end
