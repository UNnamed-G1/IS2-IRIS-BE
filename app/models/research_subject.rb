class ResearchSubject < ApplicationRecord
  has_and_belongs_to_many :users
  has_and_belongs_to_many :research_groups

  validate :name, presence: true
  validate :name, length: { maximum: 200, too_long: "Se permiten máximo %´{count} caracteres" }
end
