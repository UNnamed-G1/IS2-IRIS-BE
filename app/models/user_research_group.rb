class UserResearchGroup < ApplicationRecord
  belongs_to :user
  belongs_to :research_group

  enum state: [:retirado, :activo]
  enum type_urg: [:miembro, :lider]

  validates :joining_date, :type_urg, :state, presence: true
  validates :state, inclusion: {in: states.keys, message: "El estado no es valido"}
  validates :type_urg, inclusion: {in: type_urgs.keys, message: "Tipo de usuario no valido"}
  validates :hours_per_week, numericality: {only_integer: true}
end
