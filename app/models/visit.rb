class Visit < ApplicationRecord
  belongs_to :user                      # 記録対象のユーザー（=誰が来る？をユーザーで管理する場合）
  belongs_to :created_by, class_name: 'User', optional: true
  validates :visit_on, presence: true
  # 重複OKなので一意制約なし
end