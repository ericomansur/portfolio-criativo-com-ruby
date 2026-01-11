class RankingController < ApplicationController
  def index
    @most_liked = Project
      .left_joins(:likes)
      .where(public: true)
      .group(:id)
      .order("COUNT(likes.id) DESC")
      .limit(10)

    @most_viewed = Project
      .left_joins(:project_views)
      .where(public: true)
      .group(:id)
      .order("COUNT(project_views.id) DESC")
      .limit(10)
  end
end
