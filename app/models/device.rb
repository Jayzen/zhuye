class Device < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :category, optional: true, counter_cache: true
  has_many :device_attaches, dependent: :destroy
  default_scope { order("weight desc") }

  validates :name, presence: { message: "名称不能为空" }
  validates :details, presence: { message: "详细信息不能为空" }
  validates :category_id, presence: { message: "标签不能为空" }
  validates :location, presence: { message: "位置不能为空" }

  module Status
    On = true
    Off = false
  end
end
