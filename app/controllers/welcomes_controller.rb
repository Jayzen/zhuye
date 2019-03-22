class WelcomesController < ApplicationController
  layout "official"
  before_action :ensure_subdomain
  before_action :find_options

  def show
    @introduction = @show_user.introductions.where(reveal: true).first
  end

  def feedback
    if @show_user.has_role?(:feedback)
      @feedback = Feedback.new
    else
      redirect_to root_path
    end
  end

  def employee
  end


  def introduction
    if @show_user.has_role?(:introduction)
      @introduction = @show_user.introductions.where(reveal: true).first
    else
      redirect_to root_path
    end
  end

  def article
    if @show_user.has_role?(:article)
      @releases = @show_user.articles.where(reveal: true).page(params[:page])
    else
      redirect_to root_path
    end
  end

  def photograph
    if @show_user.has_role?(:photograph)
      @photographs = @show_user.photographs.where(reveal: true).page(params[:page])
    else
      redirect_to root_path
    end
  end 

  #set /release/:id
  def press
    if @show_user.has_role?(:article)
      @release = @show_user.articles.where(reveal: true).find(params[:id])
    else
      redirect_to root_path
    end
  end

  def service
    if @show_user.has_role?(:service)
      @services = @show_user.services.where(reveal: true).page(params[:page])
    else
      redirect_to root_path
    end
  end

  #set /service/:id
  def serve
    if @show_user.has_role?(:service)
      @service = @show_user.services.where(reveal: true).find(params[:id])
    else
      redirect_to root_path
    end
  end

  def recruit
    if @show_user.has_role?(:recruit)
      @recruits = @show_user.recruits.where(reveal: true).order("updated_at desc").page(params[:page])
    else
      redirect_to root_path
    end
  end

  #set /recruit/:id
  def invite
    if @show_user.has_role?(:recruit)
      @recruit = @show_user.recruits.where(reveal: true).find(params[:id])
    else
      redirect_to root_path
    end
  end
  
  def map
    if @show_user.has_role?(:map)
      @map = @show_user.maps.first
    else
      redirect_to root_path
    end 
  end

  private
    def ensure_subdomain
      @show_user ||= User.find_by(subdomain: request.subdomain)
      @contact = @show_user.contacts.where(reveal: true).first
      set_meta_tags(keywords: @show_user.basic.keywords)
      redirect_to root_url(subdomain: nil) unless @show_user.present?
    end

    def find_options
      @available_roles = @show_user.roles.reject{ |role| (role == :user) || (role == :root_admin) }.map(&:to_s)
      @options = @show_user.options.where(name: @available_roles).where(reveal: true).order(:position)
      if @show_user.options.find_by(name: "carousel")
        @carousel_option = @show_user.options.find_by(name: "carousel").reveal
      end
      @carousels = @show_user.carousels.where(reveal: true)
      if @carousels.size == 0
        @carousels = nil
      end
      @map = @show_user.maps.first
      @background = @show_user.navbar.background
      @color = @show_user.navbar.color
      @basic_background = @show_user.basic.background
      @navbar_position = @show_user.navbar.position
      @basic_contact = @show_user.basic.contact
      @basic_map_position = @show_user.basic.map_position
      @basic_small_map = @show_user.basic.small_map
    end
end
