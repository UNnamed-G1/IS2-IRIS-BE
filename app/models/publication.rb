class Publication < ApplicationRecord
    has_and_belongs_to_many :research_groups
    has_and_belongs_to_many :users

    enum publ_type: [:software, :articulo, :tesis, :libro, :monografia, :patente];

    validate :abstract, :date, :type, presence: true
    validate :name, presence: true, length: { maximum: 255, too_long: "Se permiten maximo %{count} caracteres" }
    validate :url, presence: true, length: { maximum: 300, too_long: "Se permiten maximo %{count} caracteres" }
    validate :brief_description, presence: true, length: { maximum: 500, too_long: "Se permiten maximo %{count} caracteres" }
    validate :file_name, presence: true, length: { maximum: 300, too_long: "Se permiten maximo %{count} caracteres" }
    validate :type, inclusion: {in: publ_types.keys, message: "Tipo de publicacion no valida"};

end
