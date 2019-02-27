class Carousel < ApplicationRecord
  belongs_to :user, optional: true

  mount_uploader :attach, OfficialCarouselAttachUploader
  default_scope { order("weight desc") }

  validates :name, presence: { message: "轮播图标题不能为空" }
  validates :introduction, presence: { message: "轮播图介绍不能为空" }
  validates :attach, presence: { message: "必须上传轮播图附件" }

  module Status
    On = true
    Off = false
  end
end
