class Photograph < ApplicationRecord
  validates :name, presence: { message: "照片名称不能为空" }
  validates :image, presence: { message: "照片附件不能为空" }

  belongs_to :user
  mount_uploader :image, PhotographImageUploader
  default_scope { order("weight desc") }
end
