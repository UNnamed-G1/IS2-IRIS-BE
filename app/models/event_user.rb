class EventUser < ApplicationRecord
    belongs_to :user
    belongs_to :event

    enum type_user_event: [:invitado, :asistente, :author]

    validates :type_user_event, presence: :true
    validates :type_user_event, inclusion: {in: type_user_events, message: "El tipo de usuario no es válido"}

    scope :author, ->{ where(type_user_event: :author) }
end
