class Information < ApplicationRecord
  belongs_to :user, optional: true

  mount_uploader :wechat, OfficialBasicWechatUploader
  default_scope { order("weight desc") }

  validates :contact, presence: { message: "联系方式不能为空" }
  validates :address, presence: { message: "地址不能为空" }

  module Status
    On = true
    Off = false
  end
end
