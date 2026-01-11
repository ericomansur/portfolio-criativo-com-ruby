# app/controllers/search_controller.rb
class SearchController < ApplicationController
  before_action :authenticate_user!

  def index
    @query = params[:q].to_s.strip
    return if @query.blank?

    @users = User.where("username ILIKE ?", "%#{@query}%")

    @projects = Project
      .includes(:user)
      .where(public: true)
      .where(
        "projects.title ILIKE :q OR projects.description ILIKE :q OR users.username ILIKE :q",
        q: "%#{@query}%"
      )
      .references(:user)
  end
end
