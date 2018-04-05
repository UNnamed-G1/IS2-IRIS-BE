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

    validates :name, presence: { message: Proc.new { ApplicationRecord.presence_msg("nombre") } }
    validates :description, presence: { message: Proc.new { ApplicationRecord.presence_msg("descripción") } }
    validates :strategic_focus, presence: { message: Proc.new { ApplicationRecord.presence_msg("enfoque estratégico") } }
    validates :research_priorities, presence: { message: Proc.new { ApplicationRecord.presence_msg("prioridades de investigación") } }
    validates :foundation_date, presence: { message: Proc.new { ApplicationRecord.presence_msg("fecha de creación") } }
    validates :classification, presence: { message: Proc.new { ApplicationRecord.presence_msg("clasificación") } }
    validates :date_classification, presence: { message: Proc.new { ApplicationRecord.presence_msg("fecha de clasificación") } }
    
    validates :name, length: {maximum: 100, too_long: "Se permiten máximo %{count} caracteres para el campo nombre."}
    validates :description, length: { maximum: 1000, too_long: "Se permiten maximo %{count} caracteres para el campo descripción." }
    validates :strategic_focus, length: { maximum: 1000, too_long: "Se permiten maximo %{count} caracteres para el campo enfoque estratégico." } 
    validates :research_priorities, length: { maximum: 1000, too_long: "Se permiten maximo %{count} caracteres para el campo prioridades de investigación." } 
    validates :classification, inclusion: { in: classifications, message: "El tipo de clasificación no es válido."}

    def member_is_lider?(member)
        m = user_research_groups.find_by(user_id: member.id)
        return m.type_urg == "lider" 
    end
end
