# == Schema Information
#
# Table name: users
#
#  id                   :integer          not null, primary key
#  name                 :string(100)
#  lastname             :string(100)
#  username             :string(40)
#  email                :string           not null
#  password_digest      :string           not null
#  professional_profile :text(5000)
#  type_u               :integer          not null
#  phone                :string(20)
#  office               :string(20)
#  cvlac_link           :string
#  career_id            :integer
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#

class User < ApplicationRecord
  has_secure_password

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

  enum user_type: [:estudiante, :profesor, :admin]

  validates :password_digest, :email, :type_u, presence: true, on: :create
  validates :name, :lastname, :username, :professional_profile, presence: true, on: :update
  
  validates :name, :lastname, length: { maximum: 100, too_long: "Se permiten máximo %´{count} caracteres" }
  validates :username, length: { maximum: 40, too_long: "Se permiten máximo %´{count} caracteres" }
  validates :professional_profile, length: { maximum: 5000, too_long: "Se permiten máximo %{count} caracteres" }
  validates :phone, :office, length: { maximum: 20, too_long: "Se permiten máximo %´{count} caracteres" }
  validates :type_u, inclusion: {in: user_types.values, message: "El tipo de usuario no es válido"}
  validates :email, uniqueness: true, format: { with: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/ }

  validates_length_of       :password, minimum: 6, on: :create
  validates_confirmation_of :password, allow_blank: false, on: :create
  
  ###Queries for searching
  
  def self.search_users_by_research_group(group_id)
    select(:id, :name, :lastname, :email, :type_u).joins(:research_groups)
                                                  .where('research_groups.id': group_id) if group_id.present?
  end
  
  ##Queries for statistics
  
  def self.num_users_by_rg(group_id)
    joins(:research_groups).where('research_groups.id': group_id).count if group_id.present?
  end
  
end
