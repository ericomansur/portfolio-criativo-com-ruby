class RankingController < ApplicationController
  def index
    @trending = Rails.cache.fetch("ranking_trending_7d", expires_in: 10.minutes) do
      Project
        .where(public: true)
        .where("created_at >= ?", 7.days.ago)
        .order(Arel.sql("(likes_count * 3 + comments_count * 5 + views_count) DESC"))
        .limit(10)
    end

    @all_time = Rails.cache.fetch("ranking_all_time", expires_in: 30.minutes) do
      Project
        .where(public: true)
        .order(Arel.sql("(likes_count * 3 + comments_count * 5 + views_count) DESC"))
        .limit(10)
    end
  end
end
