class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @project = Project.find(params[:project_id])
    @comment = @project.comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to request.referer }
      end
    else
      redirect_to request.referer, alert: "Erro ao comentar"
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
