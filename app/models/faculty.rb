class Faculty < ApplicationRecord
  has_many :departments

  validates :name, presence: { message: Proc.new { ApplicationRecord.presence_msg("nombre") } }
  validates :name, length: {maximum: 100, too_long: "Se permiten máximo %´{count} caracteres en el campo nombre."}
end
