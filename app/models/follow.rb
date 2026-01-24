class Follow < ApplicationRecord
  belongs_to :follower, class_name: "User"
  belongs_to :following, class_name: "User"

  has_many :notifications, as: :notifiable, dependent: :destroy

  validates :follower_id, uniqueness: { scope: :following_id }
  validate :cannot_follow_yourself

  after_create :create_notification

  private

  def cannot_follow_yourself
    errors.add(:follower_id, "não pode seguir a si mesmo") if follower_id == following_id
  end

  def create_notification
    Notification.create(
      user: following,
      actor: follower,
      notifiable: self,
      action: "follow"
    )
  end
end