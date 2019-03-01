class WelcomesController < ApplicationController
  before_action :ensure_subdomain, except: [:index]
  before_action :find_options, except: [:index]
  before_action :set_select, only: [:index]

  def index
    @user = User.find_by(email: "demo@demo.com")
    @carousels = @user.carousels.where(reveal: true)
  end

  def show
    set_meta_tags(keywords: @show_user.basic.keywords)

    if @show_user.option == "advertise"
      @carousels = @show_user.carousels.where(reveal: true)
      @employees = @show_user.employees.where(reveal: true)
      @photographs = @show_user.photographs.where(reveal: true)
      @article = @show_user.articles.where(reveal: true).first
      @contact = @show_user.contacts.where(reveal: true).first
      @map = @show_user.maps.first
      @set_advertise = @show_user.set_advertise
      
      #set option name
      @map_name = @options.find_by(name: "map")
      
      render layout: "advertise"
    elsif @show_user.option == "official"
      render layout: "official"
    end
  end

  def feedback
    if @show_user.has_role?(:feedback)
      @feedback = Feedback.new
      render layout: "official"
    else
      redirect_to root_path
    end
  end

  def introduction
    if @show_user.has_role?(:introduction)
      @introduction = @show_user.introductions.where(reveal: true).first
      render layout: "official"
    else
      redirect_to root_path
    end
  end

  def article
    if @show_user.has_role?(:article)
      @releases = @show_user.articles.where(reveal: true).page(params[:page])
      render layout: "official"
    else
      redirect_to root_path
    end
  end

  #set /release/:id
  def press
    if @show_user.has_role?(:article)
      @release = @show_user.articles.where(reveal: true).find(params[:id])
      render layout: "official"
    else
      redirect_to root_path
    end
  end

  def service
    if @show_user.has_role?(:service)
      @services = @show_user.services.where(reveal: true).page(params[:page])
      render layout: "official"
    else
      redirect_to root_path
    end
  end

  #set /service/:id
  def serve
    if @show_user.has_role?(:service)
      @service = @show_user.services.where(reveal: true).find(params[:id])
      render layout: "official"
    else
      redirect_to root_path
    end
  end

  def recruit
    if @show_user.has_role?(:recruit)
      @recruits = @show_user.recruits.where(reveal: true).order("updated_at desc").page(params[:page])
      render layout: "official"
    else
      redirect_to root_path
    end
  end

  #set /recruit/:id
  def invite
    if @show_user.has_role?(:recruit)
      @recruit = @show_user.recruits.where(reveal: true).find(params[:id])
      render layout: "official"
    else
      redirect_to root_path
    end
  end
  
  def map
    if @show_user.has_role?(:map)
      @map = @show_user.maps.first
      render layout: "official"
    else
      redirect_to root_path
    end 
  end

  private
    def ensure_subdomain
      @show_user ||= User.find_by(subdomain: request.subdomain)
      @contact = @show_user.contacts.where(reveal: true).first
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
    end

    def set_select
      if user_signed_in?
        unless current_user.option
          redirect_to select_path
        end
      end
    end
end
