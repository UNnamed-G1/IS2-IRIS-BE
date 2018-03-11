class Event < ApplicationRecord
    has_and_belongs_to_many :users
    has_many :photos, as: :imageable
    belongs_to :research_group

    enum type: [:privado, :publico]
    enum frequence: [:unico, :repetitivo]
    enum state: [:activo, :inactivo]

    validates :topic, :description, :state, presence: true
    validates :type, :date, :frequence, :end_time, presence: true
    validates :type, inclusion: {in: types.keys, message: "Tipo de evento invalido."}
    validates :frequence, inclusion: {in: frequences.keys, message: "Frecuencia del evento invalida."}
    validates :state, inclusion: {in: states.keys, message: "Estado del evento invalido."}
end
