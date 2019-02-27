class Option < ApplicationRecord
  belongs_to :user, optional: true

  validates :show, presence: { message: "名称不能为空" }
end
