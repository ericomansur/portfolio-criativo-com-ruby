# app/models/user.rb
class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :avatar
  has_many :projects, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :notifications, dependent: :destroy
  has_many :active_follows, class_name: "Follow", foreign_key: "follower_id", dependent: :destroy
  has_many :passive_follows, class_name: "Follow", foreign_key: "following_id", dependent: :destroy

  has_many :following, through: :active_follows, source: :following
  has_many :followers, through: :passive_follows, source: :follower

  validates :username, presence: true, uniqueness: true

  def following?(user)
    following.include?(user)
  end

  def follow(user)
    return if self == user
    following << user unless following?(user)
  end

  def unfollow(user)
    following.delete(user)
  end

  def followers_count
    followers.count
  end

  def following_count
    following.count
  end
end