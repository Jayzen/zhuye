class DeviceAttach < ApplicationRecord
  belongs_to :device, optional: true
  
  mount_uploader :name, DeviceAttachNameUploader 
end
