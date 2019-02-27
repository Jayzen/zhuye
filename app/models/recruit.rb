class Recruit < ApplicationRecord
  belongs_to :user, optional: true

  default_scope { order("weight desc") }

  validates :title, presence: { message: "标题不能为空" }
  validates :content, presence: { message: "内容不能为空" }
end
