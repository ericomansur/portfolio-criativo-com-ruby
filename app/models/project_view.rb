class ProjectView < ApplicationRecord
  belongs_to :project, counter_cache: :views_count
  belongs_to :user, optional: true
end
