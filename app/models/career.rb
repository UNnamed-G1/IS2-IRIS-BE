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
# Foreign Keys
#
#  fk_rails_...  (department_id => departments.id)
#

class Career < ApplicationRecord
  has_many :career_research_groups, dependent: :delete_all
  has_many :research_groups, through: :career_research_groups
  has_many :users, dependent: :delete_all
  belongs_to :department

  enum degree_type: [ :pregado, :maestria, :doctorado]

  validates :name, presence: { message: Proc.new { ApplicationRecord.presence_msg("nombre") } }
  validates :snies_code, presence: { message: Proc.new { ApplicationRecord.presence_msg("código SNIES") } }
  validates :degree_type, presence: { message: Proc.new { ApplicationRecord.presence_msg("tipo de título") } }
  validates :name, length: {maximum: 100, too_long: "Se permiten máximo %´{count} caracteres para el campo nombre."}
  validates :degree_type, inclusion: {in: degree_types, message: "El tipo de carrera seleccionado no es válido."}
  validates :snies_code, length: {maximum: 5, too_long: "Código SNIES no es válido"}
  validates :snies_code, uniqueness: { message: "Código SNIES ya ha sido usado en otro registro."} 
  validates :snies_code, numericality: { only_integer: true, message: "El código SNIES debe ser un número."}

  ###Queries for searching

  def self.search_careers_by_rg(rg_id)
    select(:id, :name).joins(:research_groups)
                      .where('research_groups.id' => rg_id) if rg_id.present?
  end

  def self.search_careers_by_user(usr_id)
    select(:id, :name).joins(:users)
                      .where('users.id' => usr_id) if usr_id.present?
  end

  def self.search_careers_by_dept(dept_id)
    select(:id, :name).where(department_id: dept_id) if dept_id.present?
  end

end
