class Logo < ApplicationRecord
  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h
  mount_uploader :name, LogoUploader
  after_update :crop_name

  belongs_to :user, optional: true
  validates :name, presence: { message: "不能上传空文件" }

  def crop_name
    name.recreate_versions! if crop_x.present?
  end
end
