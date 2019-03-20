class ApplicationController < ActionController::Base
  include DeviseWhitelist
  before_action :set_locale

  def after_sign_in_path_for(resource)
    options_path
  end

  private
    def set_locale
      I18n.locale = params[:locale] || I18n.default_locale 
    end
end
