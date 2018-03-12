class Event < ApplicationRecord
<<<<<<< HEAD
    validates :topic, :description_topic, presence: true, length: { maximum: 1024, too_long: "Se permiten maximo %{count} caracteres" }
    validates :id_event, :id_group, :type_event, :date_time, :frequence, :end_time_event, presence: true
end

=======
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
>>>>>>> da0d017d6b98af73f220b6150bb010914eca3ae9
