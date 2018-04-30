# == Schema Information
#
# Table name: careers
#
#  id            :bigint(8)        not null, primary key
#  name          :string(100)      not null
#  snies_code    :bigint(8)        not null
#  degree_type   :integer          default("pregado"), not null
#  department_id :bigint(8)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
# Indexes
#
#  index_careers_on_department_id  (department_id)
#
# Foreign Keys
#
#  fk_rails_...  (department_id => departments.id)
#

class CareerSerializer < ActiveModel::Serializer
  type :career
  
  attributes :id, :name, :snies_code, :degree_type

  has_many :users
  has_many :research_groups
  belongs_to :department
end
