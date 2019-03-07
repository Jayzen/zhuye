class DevicesController < ApplicationController
  before_action :authenticate_user!, except: [:public_show]
  before_action :set_device, only: [:rqrcode, :show, :edit, :update, :destroy, :delete, :set_weight, :set_reveal]
  before_action :set_devices, only: [:index, :set_weight, :set_reveal]
  before_action :set_left_bar, except: [:public_show]
  before_action :set_categories, only: [:new, :edit, :create, :update]
  #access device: :all, message: "当前用户无权访问"

  def public_show
    @device = Device.find(params[:id])
    @device_attaches = @device.device_attaches
    render layout: "dimension"
  end

  def rqrcode
    qr_code_img = RQRCode::QRCode.new(public_show_device_url(@device))
    png = qr_code_img.as_png(
      resize_gte_to: false,
      resize_exactly_to: false,
      fill: 'white',
      color: 'black',
      size: 300,
      border_modules: 4,
      module_px_size: 6,
      file: nil # path to write
    )
    @device.update_attribute :qr_code, png.to_s
  end

  def lists
    @device = current_user.devices.find(params[:id])
    @device_attaches = @device.device_attaches
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
    @device = Device.find(params[:id])
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
    @device = current_user.devices.build(device_params)
    if @device.save
      if params[:images]
        @device_error = []
        params[:images].each do |image|
          @device_return = @device.device_attaches.create(name: image)
          @device_error += @device_return.errors.messages.values.flatten
        end
        if @device_error.size == 0
          flash[:success] = "创建成功"
          redirect_to devices_path
        else
          flash[:danger] = @device_error.first
          redirect_to edit_device_path(@device)
        end
      else
        flash[:success] = "创建成功"
        redirect_to devices_path
      end
    else
      render :new
    end
  end

  # PATCH/PUT /devices/1
  def update
    if @device.update(device_params)
      if params[:images]
        @device_error = []
        params[:images].each do |image|
          @device_return = @device.device_attaches.create(name: image)
          @device_error += @device_return.errors.messages.values.flatten
        end
        if @device_error.size == 0
          flash[:success] = "更新成功"
          redirect_to devices_path
        else
          flash[:danger] = @device_error.first
          redirect_to edit_device_path(@device)
        end
      else
        flash[:success] = "更新成功"
        redirect_to devices_path
      end
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
      params.require(:device).permit(:name, :details, :category_id, :location, :status)
    end

    def set_devices
      @devices = current_user.devices.includes(:category).order(updated_at: :desc).page(params[:page])
    end

    def set_left_bar
      @available_roles = current_user.roles.reject{ |role| (role == :user) || (role == :root_admin) }.map(&:to_s)
      @options = current_user.options.where(name: @available_roles).where(reveal: true).order(:position)
    end

    def set_categories
      @categories = current_user.categories.includes(:devices).where(reveal: true)
    end
end
