# == Schema Information
#
# Table name: careers
#
#  id            :integer          not null, primary key
#  name          :string(100)      not null
#  snies_code    :integer          not null
#  degree_type   :integer          default(0), not null
#  department_id :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Career < ApplicationRecord
  has_many :career_research_groups
  has_many :research_groups, through: :career_research_groups
  belongs_to :department
  has_many :users

  enum degree_type: [ :pregado, :maestria, :doctorado]

  validates :name, :snies_code, :degree_type, presence: true
  validates :name, length: {maximum: 100, too_long: "Se permiten máximo %´{count} caracteres."}
  validates :degree_type, inclusion: {in: degree_types, message: "El tipo de carrera no es válido"}
  validates :snies_code, length: {maximum: 5, too_long: "Código SNIES inválido"}, uniqueness: {message: "Codigo SNIES ya ha sido usado en otro registro."}, numericality: { only_integer: true }
  
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
