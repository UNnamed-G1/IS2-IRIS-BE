class ResearchGroup < ApplicationRecord
    has_and_belongs_to_many :publications
    has_and_belongs_to_many :careers
    has_and_belongs_to_many :research_subjects
    has_many :events
    has_many :user_research_groups
<<<<<<< HEAD
    has_many :members, class_name: "User", through: user_research_groups
    has_one :photo, as: :imageable, optional: true
=======
    has_many :members, class_name: "User", through: :user_research_groups
    has_one :photo, as: :imageable
>>>>>>> 240875a2d6eaf591163abdd0e6ebd07cb6e06e1f

    enum class_type: [:A, :B, :C, :D]

    validates :name, :description, :strategic_focus, :research_priorities, :foundation_date, :classification, :date_classification, presence: true
    validates :name, :url, length: {maximum: 100, too_long: "Se permiten máimo %{count} caracteres"}
    validates :description, :strategic_focus, :research_priorities, length: { maximum: 1000, too_long: "Se permiten maximo %{count} caracteres" }
    validates :classification, length: { in: 1..5 }, inclusion: { in: class_types.keys }
end
