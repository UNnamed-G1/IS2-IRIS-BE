# == Schema Information
#
# Table name: user_research_groups
#
#  joining_date      :date             not null
#  end_joining_date  :date             not null
#  state             :integer          default("retirado"), not null
#  type_urg          :integer          default("miembro"), not null
#  hours_per_week    :integer          default(0), not null
#  user_id           :integer
#  research_group_id :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class UserResearchGroup < ApplicationRecord
  belongs_to :user, class_name: "User"
  belongs_to :research_group, class_name: "ResearchGroup"

  enum state: [:retirado, :activo]
  enum type_urg: [:miembro, :lider]

  validates :joining_date, :type_urg, :state, presence: true
  validates :state, inclusion: {in: states.keys, message: "El estado no es valido"}
  validates :type_urg, inclusion: {in: type_urgs.keys, message: "Tipo de usuario no valido"}
  validates :hours_per_week, numericality: {only_integer: true}
end
