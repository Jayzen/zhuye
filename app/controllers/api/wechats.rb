module API
  class Wechats < Grape::API
    content_type :json, 'application/json'
    default_format :json

    get ':subdomain' do
      @user = User.find_by(subdomain: params[:subdomain])
      {carousels: @user.carousels.where(reveal: true), 
       services: @user.services.where(reveal: true),
       introduction: @user.introductions.where(reveal: true).first
      }
    end

    get ':subdomain/services/:id' do
      @user = User.find_by(subdomain: params[:subdomain])
      {service: @user.services.where(reveal: true).find(params[:id])}
    end
  end
end
