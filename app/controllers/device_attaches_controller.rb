class DeviceAttachesController < ApplicationController
  before_action :authenticate_user!
  #before_action :set_device, only: [:rqrcode, :show, :edit, :update, :destroy, :delete, :set_weight, :set_reveal]
  #before_action :set_devices, only: [:index, :set_weight, :set_reveal]
  before_action :set_left_bar
  #before_action :set_categories, only: [:new, :edit, :create, :update]
  access device: :all, message: "当前用户无权访问"

  def index
    @device = current_user.devices.find(params[:device_id]) 
    @device_attaches = @device.device_attaches
  end

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
      params[:images].each do |image|
        @device.device_attaches.create(name: image)
      end
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
    @device_attach.destroy
    flash[:success] = "删除成功"
    redirect_to lists_devices_path(id: @device_attach.device)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_device
      @device_attach = DeviceAttach.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def device_params
      params.require(:device_attach).permit(:name)
    end

    def set_devices
      @devices = current_user.devices.includes(:category).page(params[:page])
    end

    def set_left_bar
      @available_roles = current_user.roles.reject{ |role| (role == :user) || (role == :root_admin) }.map(&:to_s)
      @options = current_user.options.where(name: @available_roles).where(reveal: true).order(:position)
    end
end
