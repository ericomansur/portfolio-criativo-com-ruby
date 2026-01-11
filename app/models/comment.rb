# app/models/comment.rb
class Comment < ApplicationRecord
  belongs_to :project
  belongs_to :user

  has_many :notifications, as: :notifiable, dependent: :destroy


  validates :body, presence: true
end