class NavbarsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_navbar

  def background
  end

  def set_background
    @navbar.background = params[:navbar][:background]
    @navbar.save
    flash[:success] = "设置成功"
    redirect_to background_navbars_path
  end

  def color
  end

  def set_color
    @navbar.color = params[:navbar][:color]
    @navbar.save
    flash[:success] = "设置成功"
    redirect_to color_navbars_path
  end

  def position
  end

  def set_position
    @navbar.position = params[:navbar][:position]
    @navbar.save
    flash[:success] = "设置成功"
    redirect_to position_navbars_path
  end

  private
    def find_navbar
      @navbar = current_user.navbar
    end
end
