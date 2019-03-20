class BasicsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_basic
  before_action :set_left_bar, only: [:update, :index]
  
  def index
  end  

  def update
    if @basic.update_attributes(basic_params)
      flash[:success] = "更新成功"
      redirect_to basics_path
    else 
      render 'index'
    end
  end

  def background
  end

  def set_background
    @basic.background = params[:basic][:background]
    @basic.save
    flash[:success] = "设置成功"
    redirect_to background_basics_path
  end

  def contact
  end

  def set_contact
    @basic.contact = params[:basic][:contact]
    @basic.save
    flash[:success] = "设置成功"
    redirect_to contact_basics_path
  end 

  def map
  end

  def set_map
    @basic.map = params[:basic][:map]
    @basic.save
    flash[:success] = "设置成功"
    redirect_to map_basics_path
  end 

  def map_height
  end

  def set_map_height
    @basic.map_height = params[:basic][:map_height]
    @basic.save
    flash[:success] = "设置成功"
    redirect_to map_height_basics_path
  end 

  private
    def set_basic
      @basic = current_user.basic
    end

    def basic_params
      params.require(:basic).permit(:name, :keywords, :is_name)
    end

    def set_left_bar
      @available_roles = current_user.roles.reject{ |role| (role == :user) || (role == :root_admin) }.map(&:to_s)
      @options = current_user.options.where(name: @available_roles).where(reveal: true).order(:position)
    end
end
