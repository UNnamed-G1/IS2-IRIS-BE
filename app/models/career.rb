class Career < ApplicationRecord
  enum deg_type: [ :pregado, :maestria, :doctorado]
  belongs_to :department

  validates :name, :snies_code, :degree_type, presence: true;
  validates :name, length: {maximum: 100, too_long: "Se permiten máximo %´{count} caracteres."};
  validates :degree_type, inclusion: {in: deg_types.keys, message: "El tipo de carrera no es valido"};
  validates :snies_code, uniqueness: true, numericality: { only_integer: true };
end
