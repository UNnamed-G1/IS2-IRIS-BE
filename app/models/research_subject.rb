class ResearchSubject < ApplicationRecord
  has_and_belongs_to_many :users
<<<<<<< HEAD

  validates :name, presence: true
  validates :name, length: { maximum: 100, too_long: "Se permiten máximo %´{count} caracteres" }
=======
  has_and_belongs_to_many :research_groups

  validates :name, presence: true
  validates :name, length: { maximum: 200, too_long: "Se permiten máximo %´{count} caracteres" }
>>>>>>> da0d017d6b98af73f220b6150bb010914eca3ae9
end
