class HomepagesController < ApplicationController
  def index
    @user = User.find_by(email: "demo@demo.com")
    @carousels = @user.carousels.where(reveal: true)
    set_meta_tags(keywords: @user.basic.keywords)
  end
end
