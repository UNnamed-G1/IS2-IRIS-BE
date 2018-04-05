class Department < ApplicationRecord
  has_many :careers
  belongs_to :faculty
  
  validates :name, { message: Proc.new { ApplicationRecord.presence_msg("nombre") } }
  validates :name, length: {maximum: 100, too_long: "Se permiten máximo %´{count} caracteres para el campo nombre."}
end
