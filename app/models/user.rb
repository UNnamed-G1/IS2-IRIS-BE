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
  validates :professional_profile, length: { maximum: 5000, too_long: "Se permiten máximo %´{count} caracteres" }
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

  private
    def put_username
      username = self.email.split('@').first
      self.update_columns(username: username)
    end
end
