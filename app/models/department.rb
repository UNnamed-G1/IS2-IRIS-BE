# == Schema Information
#
# Table name: departments
#
#  id         :bigint(8)        not null, primary key
#  name       :string(100)
#  faculty_id :bigint(8)
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

class Department < ApplicationRecord
  has_many :careers, dependent: :delete_all
  belongs_to :faculty

  validates :name, presence: { message: Proc.new { ApplicationRecord.presence_msg("nombre") } }
  validates :name, length: {maximum: 100, too_long: "Se permiten máximo %´{count} caracteres para el campo nombre."}

end
