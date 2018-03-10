class Publication < ApplicationRecord
    has_and_belongs_to_many :research_groups
    
    validates :abstract, presence: true, length: { maximum: 5000, too_long:  "Se permiten maximo %{count} caracteres" }
    validates :url, presence: true, length: { maximum: 500, too_long: "Se permiten maximo %{count} caracteres " }
    validates :little_desc, presence: true, length: { maximum: 1024, too_long: "Se permiten maximo %{count} caracteres" }
    validates :file_name, presence: true, length: { maximum: 100, too_long: "Se permiten maximo %{count} caracteres" }
    validates :id_product, :publication_date, :publication_type, presence: true
    
end
