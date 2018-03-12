class Faculty < ApplicationRecord
  has_many :departments

  validates :name, presence: true, length: {maximum: 100, too_long: "Se permiten máximo %´{count} caracteres."}
end
