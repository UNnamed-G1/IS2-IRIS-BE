class Event < ApplicationRecord
    has_and_belongs_to_many :users
    has_and_belongs_to_many :photos
    belongs_to :research_group

    enum event_type: [:privado, :publico];
    enum frequence_type: [:unico, :repetitivo];
    enum event_state: [:activo, :inactivo];

    validate :topic, :description_topic, :event_state, presence: true
    validate :type_event, :date_event, :frequence, :end_time_event, presence: true
    validate :type_event, inclusion: {in: event_types.keys, message: "Tipo de evento invalido."};
    validate :frequence, inclusion: {in: frequence_types.keys, message: "Frecuencia del evento invalida."};
    validate :event_state, inclusion: {in: event_states.keys, message: "Estado del evento invalido."};
end

