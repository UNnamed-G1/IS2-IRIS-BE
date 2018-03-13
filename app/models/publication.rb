class Publication < ApplicationRecord
    has_and_belongs_to_many :research_groups
    has_and_belongs_to_many :users

    enum type_pub: [:software, :articulo, :tesis, :libro, :monografia, :patente]

    validates :name, :date, :abstract, :url, :brief_description, :type_pub, presence: true
    validates :name, length: { maximum: 255, too_long: "Se permiten maximo %{count} caracteres" }
    validates :url, :file_name, length: { maximum: 300, too_long: "Se permiten maximo %{count} caracteres" }
    validates :brief_description, length: { maximum: 500, too_long: "Se permiten maximo %{count} caracteres" }
    validates :type_pub, inclusion: {in: type_pubs.keys, message: "Tipo de publicacion no valida"}
end
