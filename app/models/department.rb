class Department < ApplicationRecord
  has_many :careers
  belongs_to :faculty

  validates :name, presence: true, length: {maximum: 100, too_long: "Se permiten máximo %´{count} caracteres."}
end
