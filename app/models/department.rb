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

class Department < ApplicationRecord
  has_many :careers, dependent: :delete_all
  belongs_to :faculty

  validates :name, presence: { message: Proc.new { ApplicationRecord.presence_msg("nombre") } }
  validates :name, length: {maximum: 100, too_long: "Se permiten máximo %´{count} caracteres para el campo nombre."}

  def self.items(p)
    paginate(page: p, per_page: 12)
  end

  def self.search_deps_by_faculty(fac_id)
      select(:id, :name).joins(:faculty)
                        .where('faculties.id' => fac_id) if fac_id.present?
  end
end
