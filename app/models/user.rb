class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :username, presence: true, uniqueness: true
end

class User < ApplicationRecord
  has_one_attached :avatar

  validates :username, presence: true, uniqueness: true
end


