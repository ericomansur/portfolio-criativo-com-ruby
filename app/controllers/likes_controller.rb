# app/controllers/likes_controller.rb
class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_project

  def create
    @project.likes.find_or_create_by(user: current_user)
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_back fallback_location: public_feed_path }
    end
  end

  def destroy
    @project.likes.where(user: current_user).destroy_all
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_back fallback_location: public_feed_path }
    end
  end

  private

  def set_project
    @project = Project.find(params[:project_id])
  end
end
