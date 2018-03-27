# == Schema Information
#
# Table name: events
#
#  id                :integer          not null, primary key
#  research_group_id :integer
#  topic             :text             not null
#  description       :text             not null
#  type_ev           :integer          not null
#  date              :datetime         not null
#  frequence         :integer          not null
#  end_time          :datetime         not null
#  state             :integer          not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class Event < ApplicationRecord
    has_many :event_users
    has_many :users, through: :event_users
    has_many :photos, as: :imageable
    belongs_to :research_group

    enum type_ev: [:privado, :publico]
    enum frequence: [:unico, :repetitivo]
    enum state: [:activo, :inactivo]

    validates :topic, :description, :state, presence: true
    validates :type_ev, :date, :frequence, :end_time, presence: true
    validates :type_ev, inclusion: {in: type_evs.keys, message: "Tipo de evento invalido."}
    validates :frequence, inclusion: {in: frequences.keys, message: "Frecuencia del evento invalida."}
    validates :state, inclusion: {in: states.keys, message: "Estado del evento invalido."}
end
