class Service < ApplicationRecord
  belongs_to :user, optional: true

  default_scope { order("weight desc") }

  validates :name, presence: { message: "名称不能为空" }
  validates :description, presence: { message: "描述不能为空" }
end
