class UserResearchGroup < ApplicationRecord
  belongs_to :user
  belongs_to :research_group

  enum state_type: [:retirado, :activo]
  enum user_type: [:asociado, :estudiante] # Faltan màs tipos

  validate :joining_date, :user_state, :user_type, presence: true;
  validate :user_state, inclusion: {in: state_types.keys, message: "El estado no es valido"};
  validate :user_type, inclusion: {in: user_types.keys, message: "Tipo de usuario no valido"};
  validate :hours_per_week, numericality: {only_integer: true}

end
