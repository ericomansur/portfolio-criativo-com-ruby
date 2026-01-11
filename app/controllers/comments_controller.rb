# app/controllers/comments_controller.rb
class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    project = Project.find(params[:project_id])
    project.comments.create(
      user: current_user,
      body: params[:comment][:body]
    )
    redirect_back fallback_location: public_feed_path
  end
end
