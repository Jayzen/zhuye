#create user
User.create(email: "demo@demo.com", subdomain: "demo", password: "111111", password_confirmation: "111111", confirmed_at: "2018-12-12",roles: :root_admin)
User.create(email: "example@example.com", subdomain: "example", password: "111111", password_confirmation: "111111", confirmed_at: "2018-12-12")
User.create(email: "one@one.com", subdomain: "one", password: "111111", password_confirmation: "111111", confirmed_at: "2018-12-12")
puts "finish add user demo"

#set root_admin roles
@user = User.first
@user.roles = @user.available_roles
@user.save
puts "finish add root_admin role to demo"

uri = "http://api.map.baidu.com/geocoder/v2/?address=#{"招贤镇象湖村"}&output=json&ak=Flmi0HpO3q8WeIPgK46kfm816ETRwGod"
encoded_uri = URI::encode(uri)
response = open(encoded_uri).read
decode_response =  ActiveSupport::JSON.decode(response)
p decode_response
