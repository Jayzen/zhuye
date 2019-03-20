class OptionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_options, only: [:set_reveal, :index]
  before_action :set_option, only: [:set_reveal]

  def index
  end

  def set_reveal
    @option.toggle!(:reveal)
    respond_to do |format|
      format.js do
      end
    end
  end

  private
    def set_option
      @option = current_user.options.find(params[:id])
    end

    def set_options
      @available_roles = current_user.roles.reject{ |role| (role == :user) || (role == :root_admin) }.map(&:to_s)
      @options = current_user.options.where(name: @available_roles).order(reveal: :desc)
    end
end
