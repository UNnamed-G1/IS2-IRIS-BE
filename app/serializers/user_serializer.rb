class UserSerializer < ActiveModel::Serializer
  type :user
  
  attributes :id, :name, :lastname, :username, :email
  attributes :professional_profile, :phone, :office, :cvlac_link
  attributes :full_name

  attribute :user_type, key: :user_type 

  has_many :events
  has_many :research_subjects
  has_many :publications
  has_many :schedules
  has_many :following
  has_many :followers
  has_many :research_groups
  has_one :photo

  belongs_to :career

  def full_name
    return object.name + " " + object.lastname
  end


end
