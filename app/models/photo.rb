class Photo < ApplicationRecord
  belongs_to :imageable, polymorphic: true

  enum imageable_type: [:usuario, :grupo_investigacion, :evento]

  validates :link, :imageable_type, presence: true
  validates :link, length: { maximum: 300, too_long: "Se permiten maximo %{count} caracteres" }
  validates :imageable_type, inclusion: {in: imageable_types.keys, message: "Tipo de imageable no valido"}
end
