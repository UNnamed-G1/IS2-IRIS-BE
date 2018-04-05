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

class Department < ApplicationRecord
  has_many :careers
  belongs_to :faculty

  validates :name, presence: true, length: {maximum: 100, too_long: "Se permiten máximo %´{count} caracteres."}
  
end
