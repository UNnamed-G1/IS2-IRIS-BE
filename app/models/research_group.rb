class ResearchGroup < ApplicationRecord
    has_and_belongs_to_many :publications
    has_many :events
    
    validates :name_group, :description_group, presence: true, length: { maximum: 1024, too_long: "Se permiten maximo %{count} caracteres" }
    validates :strategic_focus, :research_priorities, :url_group, presence: true, length: { maximum: 1024, too_long: "Se permiten maximo %{count} caracteres" }
    validates :classification, presence: true, length: { in: 1..3 }
    validates :id_group, :foundation_date, :date_classification, :id_photo, presence: true
end