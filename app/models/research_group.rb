# == Schema Information
#
# Table name: research_groups
#
#  id                  :integer          not null, primary key
#  name                :text             not null
#  description         :text             not null
#  strategic_focus     :text             not null
#  research_priorities :text             not null
#  foundation_date     :date             not null
#  classification      :integer          not null
#  date_classification :date             not null
#  url                 :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

class ResearchGroup < ApplicationRecord
    has_many :research_subject_research_groups, dependent: :delete_all
    has_many :research_subjects, through: :research_subject_research_groups

    has_many :publication_research_groups, dependent: :delete_all
    has_many :publications, through: :publication_research_groups
    has_many :career_research_groups, dependent: :delete_all
    has_many :careers, through: :career_research_groups
    has_many :events, dependent: :delete_all
    has_many :user_research_groups, dependent: :delete_all
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

    def self.items(p)
      paginate(page: p, per_page: 12)
    end

    ##Queries for searching

    def self.search_rgs_by_career(career_id)
        select(:id, :name).joins(:careers)
                          .where('careers.id' => career_id) if career_id.present?
    end

    def self.get_rgname_by_id(rg_id)
        where(id: rg_id).pluck(:name)
    end

    def self.get_name_by_publ(publ_id)
      joins(:publications).where('publications.id' => publ_id).pluck(:name) if publ_id.present?
    end

    def self.search_rgs_by_name(keywords)
        select(:id, :name).where("name LIKE ?","%#{keywords}%") if keywords.present?
    end

    def self.search_rgs_by_class(cl_type)
        select(:id, :name).where(classification: cl_type) if cl_type.present?
    end

    def self.search_rgs_by_dept(dep_id)
        select(:id, :name).joins(:careers)
                          .where('careers.department_id' => dep_id) if dep_id.present?
    end

    def self.news
        select(:name, :description, :updated_at).order(:updated_at).last(3)
    end

    def member_is_lider?(member)
        m = user_research_groups.find_by(user_id: member.id)
        return m.type_urg == "lider"
    end

end
