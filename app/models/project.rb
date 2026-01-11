class Project < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  has_many :project_views, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :notifications, as: :notifiable, dependent: :destroy

  before_validation :generate_slug, on: :create

  validates :title, presence: true
  validates :slug, presence: true, uniqueness: { scope: :user_id }

  def engagement_score
    (likes_count.to_i * 3) +
    (comments_count.to_i * 5) +
    (views_count.to_i)
  end


  private

  def generate_slug
    base = title.to_s.parameterize
    candidate = base
    count = 2

    while user.projects.exists?(slug: candidate)
      candidate = "#{base}-#{count}"
      count += 1
    end

    self.slug = candidate
  end
end
