class FeedController < ApplicationController
  def index
    @projects = Project.where(public: true)
                      .includes(:user, :likes, :comments)
                      .order(created_at: :desc)
  end

  def personalized
    unless user_signed_in?
      redirect_to new_user_session_path, alert: "Você precisa estar logado para ver seu feed personalizado."
      return
    end

    following_ids = current_user.following.pluck(:id)
    
    @projects = Project.where(user_id: [*following_ids, current_user.id], public: true)
                      .includes(:user, :likes, :comments)
                      .order(created_at: :desc)
  end
end