class Employee < ApplicationRecord
  belongs_to :user, optional: true

  default_scope { order("weight desc") }
  mount_uploader :avatar, EmployeeAvatarUploader 
  validates :name, presence: { message: "姓名不能为空" }
end
