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
  has_many :user_research_groups, dependent: :delete_all
  has_many :research_groups, through: :user_research_groups
  has_one :photo, as: :imageable

  belongs_to :career, optional: true

  enum user_type: [:estudiante, :profesor, :admin]

  validates :name, presence: { message: Proc.new { ApplicationRecord.presence_msg("nombre") } }, on: [:create, :update]
  validates :lastname, presence: { message: Proc.new { ApplicationRecord.presence_msg("apellido") } }, on: [:create, :update]
  validates :email, presence: { message: Proc.new { ApplicationRecord.presence_msg("email") } }, on: :create
  validates :user_type, presence: true, on: :create
  validates :professional_profile, presence: { message: Proc.new { ApplicationRecord.presence_msg("perfil profesional") } }, on: :update

  validates :name, length: { maximum: 100, too_long: "Se permiten máximo %{count} caracteres en el campo nombre." }
  validates :lastname, length: { maximum: 100, too_long: "Se permiten máximo %{count} caracteres en el campo apellido." }
  validates :professional_profile, length: { maximum: 5000, too_long: "Se permiten máximo %{count} caracteres en el campo perfíl profesional." }
  validates :phone, length: { maximum: 20, too_long: "Se permiten máximo %{count} caracteres en el campo teléfono." }
  validates :office, length: { maximum: 20, too_long: "Se permiten máximo %{count} caracteres en el campo oficina." }
  validates :user_type, inclusion: {in: user_types.keys, message: "El tipo de usuario no es válido."}
  validates :email, uniqueness: {message: "El email ingresado ya ha sido tomado."}
  validates_format_of :email, with: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/, message: "El correo ingresado no es valido."

  def self.create_google_user(data)
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
    select(:id, :name, :lastname, :email, :user_type).joins(:research_groups)
                                                  .where('research_groups.id' => rg_id) if rg_id.present?
  end
  
  def self.search_users_by_publ(publ_id)
    select(:id, :name, :lastname, :email, :user_type).joins(:publications)
                                                  .where('publications.id' => publ_id) if publ_id.present?
  end
  
  def self.search_users_by_rs(rs_id)
    select(:id, :name, :lastname, :email, :user_type).joins(:research_subjects)
                                                  .where('research_subjects.id' => rs_id) if rs_id.present?
  end
  
  def self.search_users_by_event(ev_id)
    select(:id, :name, :lastname, :email, :user_type).joins(:events)
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
    result = event_users.where("user_id = ? AND event_id = ?", id, event_id).author.first

    if result 
      return true
    else
      return false
    end
  end
  
  def self.find_by_email(email)
    return User.find_by email: email 
  end

  private
    def put_username
      username = self.email.split('@').first
      self.update_columns(username: username)
    end
end
