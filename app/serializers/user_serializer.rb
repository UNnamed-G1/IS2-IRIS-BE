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
#  professional_profile :text
#  user_type            :integer          default("estudiante"), not null
#  phone                :string(20)
#  office               :string(20)
#  cvlac_link           :text
#  google_sign_up       :boolean          default(FALSE)
#  career_id            :integer
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

class UserSerializer < ActiveModel::Serializer
  type :user

  attributes :id, :name, :lastname, :username, :email
  attributes :professional_profile, :phone, :office, :cvlac_link
  attributes :full_name, :google_sign_up

  attribute :user_type

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

  def user_type
    return object.user_type.capitalize
  end

end
