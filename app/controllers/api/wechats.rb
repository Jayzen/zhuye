module API
  class Wechats < Grape::API
    content_type :json, 'application/json'
    default_format :json

    get '/' do
      "wechat index"
    end
  end
end
