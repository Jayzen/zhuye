class Article < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :tag, optional: true

  default_scope { order("weight desc") }

  validates :title, presence: { message: "标题不能为空" }
  validates :content, presence: { message: "内容不能为空" }
  validates :tag_id, presence: { message: "标签不能为空" }, if: Proc.new { |article| article.user.has_role?(:root_admin) }
end
