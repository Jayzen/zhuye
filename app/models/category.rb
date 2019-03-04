class Category < ApplicationRecord
  belongs_to :user, optional: true
  has_many :devices, dependent: :destroy

  default_scope { order("weight desc") }

  validates :name, presence: { message: "名称不能为空" }, uniqueness: { message: "该名称已经存在" }
end
