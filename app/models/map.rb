class Map < ApplicationRecord
  belongs_to :user, optional: true

  validates :name, presence: { message: "地址名称不能为空" }, uniqueness: { scope: :user_id, message: "该地址已经存在" }
  validates :level, presence: { message: "放大等级不能为空"}, on: :update
  validates :level, numericality: { only_integer: true, message: "放大等级只能为整数" }, unless: Proc.new { |map| map.level.blank? },on: :update
  
  validates :longitude, presence: { message: "经度不能为空"}, on: :update
  validates :latitude, presence: { message: "纬度不能为空"}, on: :update

  default_scope { order("weight desc") }

  def self.search(name)
    uri = "https://api.map.baidu.com/geocoder/v2/?address=#{name}&output=json&ak=Flmi0HpO3q8WeIPgK46kfm816ETRwGod"
    encoded_uri = URI::encode(uri)
    response = open(encoded_uri).read
    ActiveSupport::JSON.decode(response)
  end
end
