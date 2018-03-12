class User < ApplicationRecord
  has_and_belongs_to_many :schedules
  has_and_belongs_to_many :research_subjects
<<<<<<< HEAD
  has_many :following, class_name: "Relationship", foreign_key: "follower_id"
  has_many :followers, class_name: "Relationship", foreign_key: "followed_id"

  validates :name, :username, :professional_profile, :email, presence: true
  validates :name, length: { maximum: 100, too_long: "Se permiten máximo %´{count} caracteres" }
  validates :username, length: { maximum: 30, too_long: "Se permiten máximo %´{count} caracteres" }
  validates :professional_profile, length: { maximum: 5000, too_long: "Se permiten máximo %´{count} caracteres" }
  validates :email, length: { maximum: 50, too_long: "Se permiten máximo %´{count} caracteres" }
  validates :phone, :office, length: { maximum: 10, too_long: "Se permiten máximo %´{count} caracteres" }
  validates :cvlac_link, length: { maximum: 50, too_long: "Se permiten máximo %´{count} caracteres" }
=======
  has_and_belongs_to_many :events
  has_and_belongs_to_many :publications
  has_many :following, class_name: "Relationship", foreign_key: "follower_id"
  has_many :followers, class_name: "Relationship", foreign_key: "followed_id"
  has_many :user_research_groups
  has_many :research_groups, through: :user_research_groups
  has_one :photo, as: :imageable, optional: true
  belongs_to :career, optional: true

  enum type: [:miembro, :lider]

  validates :name, :username, :professional_profile, :email, presence: true
  validates :name, length: { maximum: 100, too_long: "Se permiten máximo %´{count} caracteres" }
  validates :username, length: { maximum: 40, too_long: "Se permiten máximo %´{count} caracteres" }
  validates :professional_profile, length: { maximum: 5000, too_long: "Se permiten máximo %´{count} caracteres" }
  validates :email, length: { maximum: 100, too_long: "Se permiten máximo %´{count} caracteres" }
  validates :phone, :office, length: { maximum: 20, too_long: "Se permiten máximo %´{count} caracteres" }
  validates :cvlac_link, length: { maximum: 200, too_long: "Se permiten máximo %´{count} caracteres" }
>>>>>>> da0d017d6b98af73f220b6150bb010914eca3ae9
end
