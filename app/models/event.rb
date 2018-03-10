class Event < ApplicationRecord
    validates :topic, :description_topic, presence: true, length: { maximum: 1024, too_long: "Se permiten maximo %{count} caracteres" }
    validates :id_event, :id_group, :type_event, :date_time, :frequence, :end_time_event, presence: true
end

