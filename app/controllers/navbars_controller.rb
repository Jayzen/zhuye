class NavbarsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_navbar
  before_action :set_reveal_options, only: [:modify, :set_modify, :order, :sort]

  def order
  end

  def sort
    params[:order].each do |key, value|
      current_user.options.find(value[:id]).update(position: value[:position])
    end

    render body: nil
  end  

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

  def modify
  end

  def set_modify
    @option = current_user.options.find(params[:option][:id])
    @option.show = params[:option][:show]
    if @option.save
      flash[:success] = "条目内容更新成功"
      redirect_to modify_navbars_path
    else
      flash[:danger] = "条目内容不能为空"
      redirect_to modify_navbars_path
    end
  end

  private
    def find_navbar
      @navbar = current_user.navbar
    end

    def set_reveal_options
      @available_roles = current_user.roles.reject{ |role| (role == :user) || (role == :root_admin) }.map(&:to_s)
      @options = current_user.options.where(name: @available_roles).where(reveal: true).order(:position)
    end
end
