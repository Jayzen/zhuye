class LogosController < ApplicationController
  before_action :authenticate_user!
  before_action :set_left_bar

  def new
    if current_user.logo
      @logo = current_user.logo
    else
      @logo = current_user.build_logo
    end
  end

  def create
    @logo = current_user.build_logo(logo_params)
    if @logo.save
      flash[:success] = "头像上传成功!"
      render :crop
    else
      render :new
    end
  end

  def update
    @logo = current_user.logo
    if @logo.update_attributes(logo_params)
      @logo.save
      flash[:success] = "头像裁剪成功!"
      redirect_to new_logo_path
    else
      render :new
    end
  end
 

  private
    def logo_params
      params.require(:logo).permit(:name, :crop_x, :crop_y, :crop_w, :crop_h)
    end

    def set_left_bar
      @available_roles = current_user.roles.reject{ |role| (role == :user) || (role == :root_admin) }.map(&:to_s)
      @options = current_user.options.where(name: @available_roles).where(reveal: true).order(:position)
    end
end
