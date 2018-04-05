# == Schema Information
#
# Table name: users
#
#  id                   :integer          not null, primary key
#  name                 :string(100)      not null
#  lastname             :string(100)      not null
#  username             :string(40)
#  email                :string           not null
#  password_digest      :string
#  professional_profile :text(5000)
#  user_type            :integer          default("estudiante"), not null
#  phone                :string(20)
#  office               :string(20)
#  cvlac_link           :string
#  career_id            :integer
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#
# Indexes
#
#  index_users_on_career_id  (career_id)
#

class User < ApplicationRecord
  has_secure_password

  after_create :put_username

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

  belongs_to :career, optional: true

  enum user_type: [:estudiante, :profesor, :admin]

  validates :name, :lastname, :email, :user_type, presence: true, on: :create
  validates :name, :lastname, :username, :professional_profile, presence: true, on: :update

  validates :name, :lastname, length: { maximum: 100, too_long: "Se permiten máximo %´{count} caracteres" }
  validates :username, length: { maximum: 40, too_long: "Se permiten máximo %´{count} caracteres" }
  validates :professional_profile, length: { maximum: 5000, too_long: "Se permiten máximo %{count} caracteres" }
  validates :phone, :office, length: { maximum: 20, too_long: "Se permiten máximo %´{count} caracteres" }
  validates :user_type, inclusion: {in: user_types.keys, message: "El tipo de usuario no es válido"}
  validates :email, uniqueness: true
  validates :email, format: { with: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/ }

  def self.create_or_find_google_user(data)
    newUser = find_by email: data['email']
    if !newUser
      newUser = create do |user|
        user.name = data["name"]
        user.lastname = data["last_name"]
        user.email = data['email']
        user.password = 'google-authorized account'
      end
      newUser.update(photo: Photo.create(
        link: data['photo'],
        imageable: newUser
      ))
    end
    return newUser
  end

  def is_admin?
    return user_type == "admin"
  end

  def is_student?
    return user_type == "estudiante"
  end
  
  def is_profesor?
    return user_type == "profesor"
  end

  ###Queries for searching
  
  def self.search_users_by_rg(rg_id)
    select(:id, :name, :lastname, :email, :type_u).joins(:research_groups)
                                                  .where('research_groups.id' => rg_id) if rg_id.present?
  end
  
  def self.search_users_by_publ(publ_id)
    select(:id, :name, :lastname, :email, :type_u).joins(:publications)
                                                  .where('publications.id' => publ_id) if publ_id.present?
  end
  
  def self.search_users_by_rs(rs_id)
    select(:id, :name, :lastname, :email, :type_u).joins(:research_subjects)
                                                  .where('research_subjects.id' => rs_id) if rs_id.present?
  end
  
  def self.search_users_by_event(ev_id)
    select(:id, :name, :lastname, :email, :type_u).joins(:events)
                                                  .where('events.id' => ev_id) if ev_id.present?
  end
  
  
  ##Queries for statistics
  
  def self.num_users_by_rg(group_id)
    joins(:research_groups).where('research_groups.id' => group_id).count if group_id.present?
  end
  
  def self.num_users_by_publ(publ_id)
    joins(:publications).where('publications.id' => publ_id).count if publ_id.present?
  end
  
  def self.num_users_by_rs(rs_id)
    joins(:research_subjects).where('research_subjects.id' => rs_id).count if rs_id.present?
  end
  
  def self.num_users_by_event(ev_id)
    joins(:events).where('events.id' => ev_id).count if ev_id.present?
  end
  
  private
    def put_username
      username = self.email.split('@').first
      self.update_columns(username: username)
    end
end
