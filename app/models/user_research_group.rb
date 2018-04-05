class UserResearchGroup < ApplicationRecord
  belongs_to :user, class_name: "User"
  belongs_to :research_group, class_name: "ResearchGroup"
  
  enum state: [:retirado, :activo]
  enum type_urg: [:miembro, :lider]
  
  validates :joining_date, presence: { message: Proc.new { ApplicationRecord.presence_msg("fecha de vinculación") } }
  validates :type_urg, presence: { message: Proc.new { ApplicationRecord.presence_msg("tipo de miembro del grupo") } }
  validates :state, presence: { message: Proc.new { ApplicationRecord.presence_msg("estado") } }
  validates :state, inclusion: {in: states, message: "El estado seleccionado no es valido."}
  validates :type_urg, inclusion: {in: type_urgs, message: "El tipo de usuario seleccionado no es valido."}
  validates :hours_per_week, numericality: {only_integer: true, message: "El campo horas por semana solo acepta valores enteros."}

  scope :lider, ->{ where(type_urg: :lider) }
  scope :is_retired, ->{ where(type_urg: :retirado) }
  scope :is_active, ->{ where(type_urg: :activo) }
end
