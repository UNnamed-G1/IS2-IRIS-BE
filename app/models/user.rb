# == Schema Information
#
# Table name: users
#
#  id                   :bigint(8)        not null, primary key
#  name                 :string(100)      not null
#  lastname             :string(100)      not null
#  username             :string(40)
#  email                :string           not null
#  password_digest      :string
#  professional_profile :text
#  user_type            :integer          default("Estudiante"), not null
#  phone                :string(20)
#  office               :string(20)
#  cvlac_link           :text
#  google_sign_up       :boolean          default(FALSE)
#  career_id            :bigint(8)
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#
# Indexes
#
#  index_users_on_career_id  (career_id)
#
# Foreign Keys
#
#  fk_rails_...  (career_id => careers.id)
#

class User < ApplicationRecord
  has_secure_password

  after_create :put_username

  has_many :research_subject_users, dependent: :delete_all
  has_many :research_subjects, through: :research_subject_users
  has_many :event_users, dependent: :delete_all
  has_many :events, through: :event_users
  has_many :publication_users, dependent: :delete_all
  has_many :publications, through: :publication_users
  has_many :schedule_users, dependent: :delete_all
  has_many :schedules, through: :schedule_users
  has_many :following, class_name: "Relationship", foreign_key: "follower_id", dependent: :delete_all
  has_many :followers, class_name: "Relationship", foreign_key: "followed_id", dependent: :delete_all
  has_many :following_users, through: :following, source: "followed"
  has_many :follower_users, through: :followers, source: "follower"
  has_many :user_research_groups, dependent: :delete_all
  has_many :research_groups, through: :user_research_groups
  has_one :photo, as: :imageable

  belongs_to :career, optional: true

  enum user_type: [:Estudiante, :Profesor, :Administrador]

  validates :name, presence: {message: Proc.new { ApplicationRecord.presence_msg("nombre") }}, on: [:create, :update]
  validates :lastname, presence: {message: Proc.new { ApplicationRecord.presence_msg("apellido") }}, on: [:create, :update]
  validates :email, presence: {message: Proc.new { ApplicationRecord.presence_msg("email") }}, on: :create
  validates :user_type, presence: true, on: :create
  validates :professional_profile, presence: {message: Proc.new { ApplicationRecord.presence_msg("perfil profesional") }}, on: :update

  validates :name, length: {maximum: 100, too_long: "Se permiten máximo %{count} caracteres en el campo nombre."}
  validates :lastname, length: {maximum: 100, too_long: "Se permiten máximo %{count} caracteres en el campo apellido."}
  validates :professional_profile, length: {maximum: 5000, too_long: "Se permiten máximo %{count} caracteres en el campo perfíl profesional."}
  validates :phone, length: {maximum: 20, too_long: "Se permiten máximo %{count} caracteres en el campo teléfono."}
  validates :office, length: {maximum: 20, too_long: "Se permiten máximo %{count} caracteres en el campo oficina."}
  validates :user_type, inclusion: {in: user_types.keys, message: "El tipo de usuario no es válido."}
  validates :email, uniqueness: {message: "El email ingresado ya ha sido tomado."}
  validates_format_of :email, with: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/, message: "El correo ingresado no es valido."

  def self.items(p, per_p)
    paginate(page: p, per_page: per_p)
  end

  def self.create_google_user(data)
    newUser = find_by email: data["email"]
    if !newUser
      newUser = create do |user|
        user.name = data["name"]
        user.lastname = data["last_name"]
        user.email = data["email"]
        user.password = "google-authorized account"
        user.google_sign_up = true
      end
    end
    return newUser
  end

  def is_admin?
    return user_type == "Administrador"
  end

  def is_student?
    return user_type == "Estudiante"
  end

  def is_Profesor?
    return user_type == "Profesor"
  end

  # QUERIES FOR SEARCHING
  def self.find_by_username(username)
    find_by(username: username)
  end
  
  def self.search_by_name(keywords)
    search = "upper(name) LIKE ? or upper(lastname) LIKE ? "
    search += "or upper(concat(name, ' ', lastname)) LIKE ? "
    search += "or upper(username) LIKE ?"
    keywords = "%#{keywords}%"
    where(search, keywords, keywords, keywords, keywords)
      .includes(:photo)
      .order(name: :asc, lastname: :asc, username: :asc)
  end

  ##Queries for statistics

  def self.num_users_by_rg(group_id)
    joins(:research_groups).where("research_groups.id" => group_id).count if group_id.present?
  end

  def self.num_users_by_publ(publ_id)
    joins(:publications).where("publications.id" => publ_id).count if publ_id.present?
  end

  def self.num_users_by_rs(rs_id)
    joins(:research_subjects).where("research_subjects.id" => rs_id).count if rs_id.present?
  end

  def self.num_users_by_event(ev_id)
    joins(:events).where("events.id" => ev_id).count if ev_id.present?
  end

  scope :with_publications_count, -> {
    joins(:publications)
      .select("users.*, COUNT(publications.id) AS pubs_count")
      .order("pubs_count DESC")
      .group("users.id")
  }
  
  scope :with_publications_count_in_rg, -> (rg_id){
    joins(:publications, :research_groups)
      .select(:id, "CONCAT(users.name,' ', users.lastname) AS fullname", 
              "COUNT(publications.id) AS pubs_count")
      .where("research_groups.id = ?", rg_id)
      .order("pubs_count DESC")
      .group("users.id")
  }   


  #Queries for validations

  def is_member_of_research_group?(group_id)
    if User.joins(:research_groups).where("user_id = ? AND research_group_id = ?", id, group_id).first
      return true
    else
      return false
    end
  end

  def is_lider_of_research_group?(group_id)
    return false unless is_member_of_research_group?(group_id)

    result = user_research_groups.where("user_id = ? AND research_group_id = ?", id, group_id).lider.first
    if result
      return true
    else
      return false
    end
  end

  def is_author_publication?(publication_id)
    retrived_user = User.joins(:publications).where("user_id = ? AND publication_id = ?", id, publication_id).first
    if retrived_user
      return true
    else
      return false
    end
  end

  def is_author_event?(event_id)
    result = event_users.where("user_id = ? AND event_id = ?", id, event_id).Autor.first

    if result
      return true
    else
      return false
    end
  end

  def self.find_by_email(email)
    return User.find_by email: email
  end

  def self.find_by_id(id)
    return User.find(id)
  end

  def get_following
    return following_users
  end

  def get_followers
    return follower_users
  end

  def count_followers
    return follower_users.count
  end

  def count_following
    return following_users.count
  end

  def unfollow(user_to_unfollow)
    if following_users.delete(user_to_unfollow)
      return true
    else
      return false
    end
  end

  def request_join_research_group(research_group)
    if research_groups.where(id: research_group.id).any?
      state = UserResearchGroup.states[:Activo]
      type = UserResearchGroup.member_types[:Solicitante]
      sql = "UPDATE user_research_groups SET member_type = #{type}, state = #{state} WHERE user_id = #{id} AND research_group_id = #{research_group.id}"
      ActiveRecord::Base.connection.execute(sql)
    else
      return user_research_groups.create(
              joining_date: Time.new,
              state: :Activo,
              member_type: :Solicitante,
              research_group: research_group,
            )
    end
  end

  def cancel_request_join_research_group(research_group)
    return research_groups.delete(research_group)
  end

  def add_schedule(schedule_id)
    return schedule_users.create(schedule: Schedule.find(schedule_id))
  end

  def remove_schedule(schedule_id)
    if schedules.delete(Schedule.find(schedule_id))
      return true
    else
      return false
    end
  end

  def get_publications
    return publications.select(:id, :name, :publication_type, :date)
  end

  def search_recent_publications
    return publications.select(:id, :name, :type_pub, :date)
                        .where('publications.created_at > ?', 1.week.ago)
                        .limit(3)
  end

  scope :all_except, -> (user_id) { where.not(id: user_id) }
  scope :except_admin, -> () { where.not(user_type: user_types[:Administrador]) }

  private

  def put_username
    username = self.email.split("@").first
    self.update_columns(username: username)
  end
end
