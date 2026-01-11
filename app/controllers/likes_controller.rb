# app/controllers/likes_controller.rb
class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    project = Project.find(params[:project_id])
    project.likes.find_or_create_by(user: current_user)
    redirect_back fallback_location: public_feed_path
  end

  def destroy
    project = Project.find(params[:project_id])
    project.likes.where(user: current_user).destroy_all
    redirect_back fallback_location: public_feed_path
  end
end
