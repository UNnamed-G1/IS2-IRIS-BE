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
#  url                 :string(300)
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

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
    validates :name, :url, length: {maximum: 100, too_long: "Se permiten máximo %{count} caracteres"}
    validates :description, :strategic_focus, :research_priorities, length: { maximum: 1000, too_long: "Se permiten maximo %{count} caracteres" }
    validates :classification, inclusion: { in: classifications, message: "El tipo de clasificación no es válido"}
    
    ##Queries for searching
    
    def self.search_rgs_by_career(career_id)
        select(:id, :name).joins(:careers)
                          .where('careers.id' => career_id) if career_id.present?
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
        self.order(:updated_at).last(3)
    end 
end
