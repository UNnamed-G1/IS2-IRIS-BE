# == Schema Information
#
# Table name: faculties
#
#  id         :integer          not null, primary key
#  name       :string(100)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Faculty < ApplicationRecord
  has_many :departments

  validates :name, presence: true, length: {maximum: 100, too_long: "Se permiten máximo %´{count} caracteres."}
end
