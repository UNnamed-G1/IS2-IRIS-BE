class ResearchGroup < ApplicationRecord
    has_and_belongs_to_many :publications
<<<<<<< HEAD
    has_many :events
    
    validates :name_group, :description_group, presence: true, length: { maximum: 1024, too_long: "Se permiten maximo %{count} caracteres" }
    validates :strategic_focus, :research_priorities, :url_group, presence: true, length: { maximum: 1024, too_long: "Se permiten maximo %{count} caracteres" }
    validates :classification, presence: true, length: { in: 1..3 }
    validates :id_group, :foundation_date, :date_classification, :id_photo, presence: true
end
=======
    has_and_belongs_to_many :careers
    has_and_belongs_to_many :research_subjects
    has_many :events
    has_many :user_research_groups
    has_many :members, class_name: "User",trough: user_research_groups
    has_one :photo, as: :imageable, optional: true

    enum class_type: [:A, :B, :C, :D]

    validates :name, :description, :strategic_focus, :research_priorities, :foundation_date, :classification, :date_classification, presence: true
    validates :name, :url, length: {maximum: 100, too_long: "Se permiten máimo %{count} caracteres"}
    validates :description, :strategic_focus, :research_priorities, length: { maximum: 1000, too_long: "Se permiten maximo %{count} caracteres" }
    validates :classification, length: { in: 1..5 }, inclusion: { in: class_types.keys }
end
>>>>>>> da0d017d6b98af73f220b6150bb010914eca3ae9
