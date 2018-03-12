class Relationship < ApplicationRecord
  belongs_to :followed, class_name: "User"
  belongs_to :follower, class_name: "User"

  validates :followed_id, :follower_id, presence: true
<<<<<<< HEAD
=======
  validates :followed_id, uniqueness: { scope: :follower_id, message: "Esta relacion ya se encuentra presente"}
>>>>>>> da0d017d6b98af73f220b6150bb010914eca3ae9
end
