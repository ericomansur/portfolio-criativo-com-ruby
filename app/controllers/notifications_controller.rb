class NotificationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @notifications = current_user.notifications
      .includes(:actor, :notifiable)
      .order(created_at: :desc)
  end

  def mark_all_as_read
    current_user.notifications.unread.update_all(read: true)
    redirect_back fallback_location: notifications_path
  end
end
