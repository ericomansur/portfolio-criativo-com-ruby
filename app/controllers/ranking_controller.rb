class RankingController < ApplicationController
  def index
    @most_liked = Project
      .left_joins(:likes)
      .where(public: true)
      .select("projects.*, COUNT(likes.id) AS likes_count")
      .group("projects.id")
      .order("likes_count DESC")
      .limit(10)

    @most_viewed = Project
      .left_joins(:project_views)
      .where(public: true)
      .select("projects.*, COUNT(project_views.id) AS views_count")
      .group("projects.id")
      .order("views_count DESC")
      .limit(10)
  end
end
