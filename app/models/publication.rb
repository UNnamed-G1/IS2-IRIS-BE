class Publication < ApplicationRecord
    has_many :publication_research_groups
    has_many :research_groups, through: :publication_research_groups
    has_many :publication_users
    has_many :users, through: :publication_users

    enum type_pub: [:software, :articulo, :tesis, :libro, :monografia, :patente]

    validates :name, presence: { message: Proc.new { ApplicationRecord.presence_msg("nombre") } }
    validates :date, presence: { message: Proc.new { ApplicationRecord.presence_msg("fecha") } }
    validates :abstract, presence: { message: Proc.new { ApplicationRecord.presence_msg("abstract") } }
    validates :url, presence: { message: Proc.new { ApplicationRecord.presence_msg("link") } }
    validates :brief_description, presence: { message: Proc.new { ApplicationRecord.presence_msg("descripción breve") } }
    validates :type_pub, presence: { message: Proc.new { ApplicationRecord.presence_msg("tipo de publicación") } }
    validates :name, length: { maximum: 255, too_long: "Se permiten maximo %{count} caracteres para el campo nombre." }
    validates :brief_description, length: { maximum: 500, too_long: "Se permiten maximo %{count} caracteres para el campo descripción breve." }
    validates :type_pub, inclusion: {in: type_pubs, message: "El tipo de publicación seleccionado no es valida."}

    def self.get_research_groups(publication_id)
        return find(publication_id).research_groups.pluck(:id)
    end
end
