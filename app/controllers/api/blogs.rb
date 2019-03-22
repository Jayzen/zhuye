module API
  class Blogs < Grape::API
    content_type :json, 'application/json'
    default_format :json

    get '/' do
      "blogs index"
    end
  end
end
