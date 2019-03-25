module API
  class Wechats < Grape::API
    content_type :json, 'application/json'
    default_format :json

    get ':subdomain' do
      @user = User.find_by(subdomain: params[:subdomain])
      {carousels: @user.carousels.where(reveal: true), 
       name: @user.basic.name,
       contact: @user.contacts.where(reveal: true).first,
       introduction: @user.introductions.where(reveal: true).first,
       map: @user.maps.first
      }
    end

    get ':subdomain/services/:id' do
      @user = User.find_by(subdomain: params[:subdomain])
      {service: @user.services.where(reveal: true).find(params[:id])}
    end
  end
end
