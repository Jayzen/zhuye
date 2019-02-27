class ServicesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_service, only: [:show, :edit, :update, :destroy, :delete, :set_weight, :set_reveal]
  before_action :set_services, only: [:index, :set_weight, :set_reveal]
  before_action :set_left_bar
  access service: :all, message: "当前用户无权访问"

  # GET /services
  def index
  end

  def set_reveal
    @service.toggle!(:reveal)
    respond_to do |format|
      format.js do
      end
    end
  end

  def set_weight
    @service.update(weight: Time.now)
    respond_to do |format|
      format.js do
      end
    end
  end

  # GET /services/1
  def show
  end

  # GET /services/new
  def new
    @service = current_user.services.new
  end

  # GET /services/1/edit
  def edit
  end

  # POST /services
  def create
    @service = current_user.services.new(service_params)

    if @service.save
      flash[:success] = "创建成功"
      redirect_to services_path
    else
      render :new
    end
  end

  # PATCH/PUT /services/1
  def update
    if @service.update(service_params)
      flash[:success] = "更新成功"
      redirect_to services_path
    else
      render :edit
    end
  end


  def delete
  end

  # DELETE /services/1
  def destroy
    @service.destroy
    flash[:success] = "删除成功"
    redirect_to services_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_service
      @service = current_user.services.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def service_params
      params.require(:service).permit(:name, :description)
    end

    def set_services
      @services = current_user.services.page(params[:page])
    end

    def set_left_bar
      @available_roles = current_user.roles.reject{ |role| (role == :user) || (role == :root_admin) }.map(&:to_s)
      @options = current_user.options.where(name: @available_roles).where(reveal: true).order(:position)
    end
end
