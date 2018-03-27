class Photo < ApplicationRecord
  belongs_to :imageable, polymorphic: true

  validates :link, :imageable_type, presence: true
  validates :link, length: { maximum: 300, too_long: "Se permiten maximo %{count} caracteres" }
end
