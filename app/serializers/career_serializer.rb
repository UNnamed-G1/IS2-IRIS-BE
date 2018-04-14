# == Schema Information
#
# Table name: careers
#
#  id            :integer          not null, primary key
#  name          :string(100)      not null
#  snies_code    :integer          not null
#  degree_type   :integer          default("pregado"), not null
#  department_id :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
# Indexes
#
#  index_careers_on_department_id  (department_id)
#

class CareerSerializer < ActiveModel::Serializer
  type :career
  
  attributes :id, :name, :snies_code, :degree_type

  has_many :users
  has_many :research_groups
  belongs_to :department
end
