class Basic < ApplicationRecord
  belongs_to :user, optional: true
  mount_uploader :logo, BasicLogoUploader

  module Status
    On = true
    Off = false
  end
end
