class Notification < ApplicationRecord
  belongs_to :user
  belongs_to :actor, class_name: "User"
  belongs_to :notifiable, polymorphic: true

  scope :unread, -> { where(read: false) }
  scope :recent, -> { order(created_at: :desc) }

  def message
    case action
    when "like"
      "curtiu seu projeto"
    when "comment"
      "comentou no seu projeto"
    when "follow"
      "começou a te seguir"
    else
      "interagiu com você"
    end
  end
end