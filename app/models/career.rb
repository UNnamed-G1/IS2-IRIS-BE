class Career < ApplicationRecord
  has_and_belongs_to_many :research_groups
  belongs_to :department
  has_many :users

  enum deg_type: [ :pregado, :maestria, :doctorado]

  validates :name, :snies_code, :degree_type, presence: true
  validates :name, length: {maximum: 100, too_long: "Se permiten máximo %´{count} caracteres."}
  validates :degree_type, inclusion: {in: deg_types.values, message: "El tipo de carrera no es válido"}
  validates :snies_code, length: {maximum: 5, too_long: "Código SNIES inválido"}, uniqueness: {message: "Codigo SNIES ya ha sido usado en otro registro."}, numericality: { only_integer: true }
end