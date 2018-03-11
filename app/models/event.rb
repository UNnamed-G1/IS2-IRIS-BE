class Event < ApplicationRecord
    has_and_belongs_to_many :users
    has_and_belongs_to_many :photos
    belongs_to :research_group

    enum type: [:privado, :publico];
    enum frequence: [:unico, :repetitivo];
    enum state: [:activo, :inactivo];

    validate :topic, :description, :state, presence: true
    validate :type, :date, :frequence, :end_time, presence: true
    validate :type, inclusion: {in: event_types.keys, message: "Tipo de evento invalido."};
    validate :frequence, inclusion: {in: frequence_types.keys, message: "Frecuencia del evento invalida."};
    validate :state, inclusion: {in: event_states.keys, message: "Estado del evento invalido."};
end
