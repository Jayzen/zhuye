class Picture < ApplicationRecord
  belongs_to :user, optional: true

  mount_uploader :attach, PictureAttachUploader
end
