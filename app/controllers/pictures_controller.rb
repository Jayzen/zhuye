class PicturesController < ApplicationController
  before_action :authenticate_user!

  def create
    picture = current_user.pictures.create! attach: params[:file]
    render json: { filename: picture.attach_url }
  end
end
