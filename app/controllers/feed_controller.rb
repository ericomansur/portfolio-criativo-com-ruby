class FeedController < ApplicationController
  def index
    @projects = Project.where(public: true)
                      .includes(:user, :likes, :comments)
                      .order(created_at: :desc)
  end

  def personalized
    if user_signed_in?
      following_ids = current_user.following.pluck(:id)
      @projects = Project.where(user_id: following_ids, public: true)
                        .or(Project.where(user_id: current_user.id))
                        .includes(:user, :likes, :comments)
                        .order(created_at: :desc)
      
      if @projects.empty?
        flash.now[:notice] = "Você ainda não segue ninguém. Explore projetos públicos!"
        redirect_to public_feed_path
      end
    else
      redirect_to new_user_session_path
    end
  end
end