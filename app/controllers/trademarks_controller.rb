class TrademarksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_left_bar

  def new
    if current_user.trademark
      @trademark = current_user.trademark
    else
      @trademark = current_user.build_trademark
    end
  end

  def create
    @trademark = current_user.build_trademark(trademark_params)
    if @trademark.save
      flash[:success] = "头像上传成功!"
      render :crop
    else
      render :new
    end
  end

  def update
    @trademark = current_user.trademark
    if @trademark.update_attributes(trademark_params)
      @trademark.save
      flash[:success] = "头像裁剪成功!"
      redirect_to new_trademark_path
    else
      render :new
    end
  end
 
  def reveal
    @trademark = current_user.trademark
    @trademark.toggle!(:reveal)
    flash[:success] = "设置成功"
    redirect_to new_trademark_path
  end

  private
    def trademark_params
      params.require(:trademark).permit(:name, :crop_x, :crop_y, :crop_w, :crop_h)
    end

    def set_left_bar
      @available_roles = current_user.roles.reject{ |role| (role == :user) || (role == :root_admin) }.map(&:to_s)
      @options = current_user.options.where(name: @available_roles).where(reveal: true).order(:position)
    end
end
