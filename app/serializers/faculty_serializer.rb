class FacultySerializer < ActiveModel::Serializer
  type :faculty
  
  attributes :id, :name

  has_many :departments
end
