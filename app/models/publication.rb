class Publication < ApplicationRecord
    has_and_belongs_to_many :research_groups
<<<<<<< HEAD
    
    validates :abstract, presence: true, length: { maximum: 5000, too_long:  "Se permiten maximo %{count} caracteres" }
    validates :url, presence: true, length: { maximum: 500, too_long: "Se permiten maximo %{count} caracteres " }
    validates :little_desc, presence: true, length: { maximum: 1024, too_long: "Se permiten maximo %{count} caracteres" }
    validates :file_name, presence: true, length: { maximum: 100, too_long: "Se permiten maximo %{count} caracteres" }
    validates :id_product, :publication_date, :publication_type, presence: true
    
=======
    has_and_belongs_to_many :users

    enum type: [:software, :articulo, :tesis, :libro, :monografia, :patente]

    validates :name, :date, :abstract, :url, :brief_description, :type, presence: true
    validates :name, length: { maximum: 255, too_long: "Se permiten maximo %{count} caracteres" }
    validates :url, :file_name, length: { maximum: 300, too_long: "Se permiten maximo %{count} caracteres" }
    validates :brief_description, length: { maximum: 500, too_long: "Se permiten maximo %{count} caracteres" }
    validates :type, inclusion: {in: types.keys, message: "Tipo de publicacion no valida"}
>>>>>>> da0d017d6b98af73f220b6150bb010914eca3ae9
end
