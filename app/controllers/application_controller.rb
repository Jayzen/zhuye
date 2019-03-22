class ApplicationController < ActionController::Base
  include DeviseWhitelist
  before_action :set_locale

  def after_sign_in_path_for(resource)
    if current_user.has_roles?(:root_admin)
      admins_path
    else
      options_path
    end
  end

  private
    def set_locale
      I18n.locale = params[:locale] || I18n.default_locale 
    end
end
