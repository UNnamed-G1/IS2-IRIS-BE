class User < ApplicationRecord
  has_and_belongs_to_many :schedules
  has_and_belongs_to_many :research_subjects
  has_many :following, class_name: "Relationship", foreign_key: "follower_id"
  has_many :followers, class_name: "Relationship", foreign_key: "followed_id"

  validates :name, :username, :professional_profile, :email, presence: true
  validates :name, length: { maximum: 100, too_long: "Se permiten máximo %´{count} caracteres" }
  validates :username, length: { maximum: 30, too_long: "Se permiten máximo %´{count} caracteres" }
  validates :professional_profile, length: { maximum: 5000, too_long: "Se permiten máximo %´{count} caracteres" }
  validates :email, length: { maximum: 50, too_long: "Se permiten máximo %´{count} caracteres" }
  validates :phone, :office, length: { maximum: 10, too_long: "Se permiten máximo %´{count} caracteres" }
  validates :cvlac_link, length: { maximum: 50, too_long: "Se permiten máximo %´{count} caracteres" }
end
