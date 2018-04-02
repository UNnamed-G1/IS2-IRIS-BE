class UserResearchGroup < ApplicationRecord
  belongs_to :user, class_name: "User"
  belongs_to :research_group, class_name: "ResearchGroup"

  enum state: [:retirado, :activo]
  enum type_urg: [:miembro, :lider]

  validates :joining_date, :type_urg, :state, presence: true
  validates :state, inclusion: {in: states, message: "El estado no es valido"}
  validates :type_urg, inclusion: {in: type_urgs, message: "Tipo de usuario no valido"}
  validates :hours_per_week, numericality: {only_integer: true}
end
