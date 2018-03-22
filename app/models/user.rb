class User < ApplicationRecord
  has_many :research_subject_users
  has_many :research_subjects, through: :research_subject_users
  has_many :event_users
  has_many :events, through: :event_users

  has_many :publication_users
  has_many :publications, through: :publication_users
  has_many :schedule_users
  has_many :schedules, through: :schedule_users
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
  validates :email, uniqueness: true, format: { with: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/ }
end
