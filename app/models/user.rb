class User < ApplicationRecord
  has_and_belongs_to_many :schedules
  has_and_belongs_to_many :research_subjects
  has_and_belongs_to_many :events
  has_and_belongs_to_many :publications
  has_many :following, class_name: "Relationship", foreign_key: "follower_id"
  has_many :followers, class_name: "Relationship", foreign_key: "followed_id"
  has_many :user_research_groups
  has_many :research_groups, through: :user_research_groups
  has_one :photo, as: :imageable
  belongs_to :career

  enum user_type: [:estudiante, :profesor]

  validates :name, :lastname, :username, :professional_profile, :email, :type_u, :password, presence: true
  validates :name, :lastname, length: { maximum: 100, too_long: "Se permiten máximo %´{count} caracteres" }
  validates :username, length: { maximum: 40, too_long: "Se permiten máximo %´{count} caracteres" }
  validates :professional_profile, length: { maximum: 5000, too_long: "Se permiten máximo %´{count} caracteres" }
  validates :phone, :office, length: { maximum: 20, too_long: "Se permiten máximo %´{count} caracteres" }
  validates :type_u, inclusion: {in: user_types.values, message: "El tipo de usuario no es válido"}
  validates :email, uniquess: true, format: { with: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/ }
end
