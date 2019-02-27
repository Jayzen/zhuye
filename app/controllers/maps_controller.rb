class MapsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_map, only: [:show, :edit, :update, :destroy, :delete, :set_weight]
  before_action :set_maps, only: [:index, :set_weight]
  before_action :set_left_bar
  access map: :all, message: "当前用户无权访问"

  # GET /maps
  def index
    @map = current_user.maps.first
  end

  def set_weight
    @map.update(weight: Time.now)
    respond_to do |format|
      format.js do
      end
    end
  end

  # GET /maps/new
  def new
    @map = current_user.maps.new
  end

  # GET /maps/1/edit
  def edit
  end

  # POST /maps
  def create
    name = params[:map][:name]
    unless name.blank?
      decode_response = Map.search(name)
      if decode_response['status'] == 0
        @map = current_user.maps.build
        @map.name = params[:map][:name]
        @map.longitude = decode_response['result']['location']['lng']
        @map.latitude = decode_response['result']['location']['lat']
        @map.level = decode_response['result']['confidence']

        if @map.save
          flash[:success] = "创建成功"
          redirect_to maps_path
        else
          render :new
        end
      else
        flash[:danger] = "不存在该地址"
        redirect_to new_map_path
      end
    else
      flash[:danger] = "地址名称不能为空"
      redirect_to new_map_path
    end
  end

  # PATCH/PUT /maps/1
  def update
    if @map.update(map_params)
      flash[:success] = "更新成功"
      redirect_to maps_path
    else
      render :edit
    end
  end

  def delete
  end

  # DELETE /maps/1
  def destroy
    @map.destroy
    flash[:success] = "删除成功"
    redirect_to maps_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_map
      @map = current_user.maps.find(params[:id])
    end

    def set_maps
      @maps = current_user.maps.page(params[:page])
    end
    
    # Only allow a trusted parameter "white list" through.
    def map_params
      params.require(:map).permit(:name, :level, :longitude, :latitude)
    end

    def set_left_bar
      @available_roles = current_user.roles.reject{ |role| (role == :user) || (role == :root_admin) }.map(&:to_s)
      @options = current_user.options.where(name: @available_roles).where(reveal: true).order(:position)
    end
end
