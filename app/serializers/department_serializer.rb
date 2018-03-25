class DepartmentSerializer < ActiveModel::Serializer
  type :department
  
  attributes :id, :name

  has_many :careers
  belongs_to :faculty
end
