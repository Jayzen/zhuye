class OptionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_options, only: [:set_reveal, :index]
  before_action :set_option, only: [:set_reveal]
  before_action :set_reveal_options, only: [:modify, :set_modify, :order]

  def index
  end

  def order
  end

  def set_reveal
    @option.toggle!(:reveal)
    respond_to do |format|
      format.js do
      end
    end
  end

  def sort
    params[:order].each do |key, value|
      current_user.options.find(value[:id]).update(position: value[:position])
    end

    render body: nil
  end

  def navbar
  end

  def set_navbar
    current_user.navbar = params[:option][:navbar]
    current_user.save
    flash[:success] = "导航条位置更新成功"
    redirect_to navbar_options_path
  end
  
  def style
  end

  def set_style
    current_user.style = params[:option][:style]
    current_user.save
    flash[:success] = "样式更新成功"
    redirect_to style_options_path
  end

  def modify
  end

  def set_modify
    @option = current_user.options.find(params[:option][:id])
    @option.show = params[:option][:show]
    if @option.save
      flash[:success] = "条目内容更新成功"
      redirect_to modify_options_path
    else
      flash[:danger] = "条目内容不能为空"
      redirect_to modify_options_path
    end
  end

  def map
  end

  def set_map
    current_user.map = params[:option][:map]
    current_user.save
    flash[:success] = "地图位置更新成功"
    redirect_to map_options_path
  end


  private
    def set_option
      @option = current_user.options.find(params[:id])
    end

    def set_options
      @available_roles = current_user.roles.reject{ |role| (role == :user) || (role == :root_admin) }.map(&:to_s)
      @options = current_user.options.where(name: @available_roles).order(reveal: :desc)
    end

    def set_reveal_options
      @available_roles = current_user.roles.reject{ |role| (role == :user) || (role == :root_admin) }.map(&:to_s)
      @options = current_user.options.where(name: @available_roles).where(reveal: true).order(:position) 
    end
end
