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
    validates :type_ev, inclusion: {in: type_evs, message: "Tipo de evento invalido."}
    validates :frequence, inclusion: {in: frequences, message: "Frecuencia del evento invalida."}
    validates :state, inclusion: {in: states, message: "Estado del evento invalido."}

    def self.get_group_id(event_id)
        return Event.find(event_id).research_group_id
    end

    def is_public?
        return type_ev == "publico"
    end

    def is_private?
        return type_ev == "private"
    end
end
