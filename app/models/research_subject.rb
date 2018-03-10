class ResearchSubject < ApplicationRecord
  has_and_belongs_to_many :users

  validates :name, presence: true
  validates :name, length: { maximum: 100, too_long: "Se permiten máximo %´{count} caracteres" }
end
