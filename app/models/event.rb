class Event < ApplicationRecord
    has_many :event_users
    has_many :users, through: :event_users
    has_many :photos, as: :imageable
    belongs_to :research_group

    enum type_ev: [:privado, :publico]
    enum frequence: [:unico, :repetitivo]
    enum state: [:activo, :inactivo]

    validates :topic, presence: { message: Proc.new { ApplicationRecord.presence_msg("tema") } }
    validates :description, presence: { message: Proc.new { ApplicationRecord.presence_msg("descripción") } }
    validates :state, presence: { message: Proc.new { ApplicationRecord.presence_msg("estado") } }
    validates :type_ev, presence: { message: Proc.new { ApplicationRecord.presence_msg("tipo de evento") } }
    validates :date, presence: { message: Proc.new { ApplicationRecord.presence_msg("fecha") } }
    validates :frequence, presence: { message: Proc.new { ApplicationRecord.presence_msg("frecuencia") } }
    validates :end_time, presence: { message: Proc.new { ApplicationRecord.presence_msg("hora de finalización") } }
    validates :type_ev, inclusion: {in: type_evs, message: "El tipo de evento seleccionado no es valido."}
    validates :frequence, inclusion: {in: frequences, message: "El tipo de evento seleccionada no es valida."}
    validates :state, inclusion: {in: states, message: "El estado seleccionado no es valido."}

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
