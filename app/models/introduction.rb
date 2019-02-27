class Introduction < ApplicationRecord
  belongs_to :user, optional: true

  default_scope { order("weight desc") }

  validates :content, presence: { message: "内容不能为空" }
end
