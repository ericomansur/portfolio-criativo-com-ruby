# app/models/comment.rb
class Comment < ApplicationRecord
  belongs_to :project, counter_cache: true
  belongs_to :user

  has_many :notifications, as: :notifiable, dependent: :destroy


  validates :body, presence: true
end