# == Schema Information
#
# Table name: departments
#
#  id         :integer          not null, primary key
#  name       :string(100)
#  faculty_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_departments_on_faculty_id  (faculty_id)
#
# Foreign Keys
#
#  fk_rails_...  (faculty_id => faculties.id)
#

class DepartmentSerializer < ActiveModel::Serializer
  type :department
  
  attributes :id, :name

  has_many :careers
  belongs_to :faculty
end
