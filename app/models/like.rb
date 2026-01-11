class Like < ApplicationRecord
  belongs_to :project, counter_cache: true
  belongs_to :user

  validates :user_id, uniqueness: { scope: :project_id }
end