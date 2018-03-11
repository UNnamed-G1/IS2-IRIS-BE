class ResearchGroup < ApplicationRecord
    has_and_belongs_to_many :publications
    has_and_belongs_to_many :careers
    has_and_belongs_to_many :research_subjects
    has_many :events
    has_many :user_research_groups;
    has_many :members, class_name: "User",trough: user_research_groups;

    enum class_type: [:A, :B, :C, :D];

    validates :name_group, :description_group, presence: true, length: { maximum: 1024, too_long: "Se permiten maximo %{count} caracteres" }
    validates :strategic_focus, :research_priorities, :url_group, presence: true, length: { maximum: 1024, too_long: "Se permiten maximo %{count} caracteres" }
    validates :classification, presence: true, length: { in: 1..5 }
    validates :classification, inclusion: { in: class_types.values };
    validates :id_group, :foundation_date, :date_classification, :id_photo, presence: true
end