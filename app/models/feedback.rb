class Feedback < ApplicationRecord
  belongs_to :user, optional: true

  default_scope { order("status").order("created_at desc") }
  validates :name, presence: { message: "联系方式不能为空" }
  validates :content, presence: { message: "评论内容不能为空" }
end
