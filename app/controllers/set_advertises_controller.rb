class SetAdvertisesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_advertise 

  def contact
  end

  def set_contact
    @set_advertise.contact = params[:set_advertise][:contact]
    @set_advertise.save
    flash[:success] = "基本信息栏位置更新成功"
    redirect_to contact_set_advertises_path
  end

  def map_height
  end

  def set_map_height
    @set_advertise.map_height = params[:set_advertise][:map_height]
    if @set_advertise.save
      flash[:success] = "地图高度更新成功"
      redirect_to map_height_set_advertises_path
    else
      flash[:danger] = "数值必须在0-500之间"
      redirect_to map_height_set_advertises_path
    end
  end


  private
    def set_advertise
      @set_advertise = current_user.set_advertise
    end
end
