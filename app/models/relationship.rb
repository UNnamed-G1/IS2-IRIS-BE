class Relationship < ApplicationRecord
  belongs_to :followed, class_name: "User"
  belongs_to :follower, class_name: "User"

  validates :followed_id, :follower_id, presence: true
  validates :followed_id, uniqueness: { scope: :follower_id, message: "Esta relación ya se encuentra presente." }
  
end
