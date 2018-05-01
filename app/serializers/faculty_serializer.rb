# == Schema Information
#
# Table name: faculties
#
#  id         :bigint(8)        not null, primary key
#  name       :string(100)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class FacultySerializer < ActiveModel::Serializer
  type :faculty
  
  attributes :id, :name

  has_many :departments
end
