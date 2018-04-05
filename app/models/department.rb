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

class Department < ApplicationRecord
  has_many :careers
  belongs_to :faculty

  validates :name, presence: { message: Proc.new { ApplicationRecord.presence_msg("nombre") } }
  validates :name, length: {maximum: 100, too_long: "Se permiten máximo %´{count} caracteres para el campo nombre."}

  def self.search_deps_by_faculty(fac_id)
      select(:id, :name).joins(:faculty)
                        .where('faculties.id' => fac_id) if fac_id.present?
  end
end
