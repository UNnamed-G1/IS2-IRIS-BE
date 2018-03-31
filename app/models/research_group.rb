class ResearchGroup < ApplicationRecord
    has_many :research_subject_research_groups
    has_many :research_subjects, through: :research_subject_research_groups
    
    has_many :publication_research_groups
    has_many :publications, through: :publication_research_groups
    has_many :career_research_groups
    has_many :careers, through: :career_research_groups 
    has_many :events
    has_many :user_research_groups
    has_many :members, class_name: "User", through: :user_research_groups
    has_one :photo, as: :imageable

    enum classification: [:A, :B, :C, :D]

    validates :name, :description, :strategic_focus, :research_priorities, :foundation_date, :classification, :date_classification, presence: true
    validates :name, :url, length: {maximum: 100, too_long: "Se permiten máimo %{count} caracteres"}
    validates :description, :strategic_focus, :research_priorities, length: { maximum: 1000, too_long: "Se permiten maximo %{count} caracteres" }
    validates :classification, inclusion: { in: classifications.keys, message: "El tipo de clasificación no es válido"}
end
