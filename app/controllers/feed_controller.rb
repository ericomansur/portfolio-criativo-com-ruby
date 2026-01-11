# app/controllers/feed_controller.rb
class FeedController < ApplicationController
  def index
    @projects = Project
      .includes(:user)
      .where(public: true)
      .order(created_at: :desc)
  end
end