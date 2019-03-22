module API
  class Wechats < Grape::API
    content_type :json, 'application/json'
    default_format :json

    get ':subdomain' do
      @user = User.find_by(subdomain: params[:subdomain])
    end
  end
end
