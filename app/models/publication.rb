# == Schema Information
#
# Table name: publications
#
#  id                :integer          not null, primary key
#  name              :text             not null
#  date              :date             not null
#  abstract          :text             not null
#  document          :text
#  brief_description :string(500)      not null
#  type_pub          :integer          not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class Publication < ApplicationRecord
    has_many :publication_research_groups, dependent: :delete_all
    has_many :research_groups, through: :publication_research_groups
    has_many :publication_users, dependent: :delete_all
    has_many :users, through: :publication_users

    mount_base64_uploader :document, DocumentUploader

    enum type_pub: [:software, :articulo, :tesis, :libro, :monografia, :patente]

    validates :name, presence: { message: Proc.new { ApplicationRecord.presence_msg("nombre") } }
    validates :date, presence: { message: Proc.new { ApplicationRecord.presence_msg("fecha") } }
    validates :abstract, presence: { message: Proc.new { ApplicationRecord.presence_msg("abstract") } }
    validates :brief_description, presence: { message: Proc.new { ApplicationRecord.presence_msg("descripción breve") } }
    validates :type_pub, presence: { message: Proc.new { ApplicationRecord.presence_msg("tipo de publicación") } }
    validates :brief_description, length: { maximum: 500, too_long: "Se permiten maximo %{count} caracteres para el campo descripción breve." }
    validates :type_pub, inclusion: {in: type_pubs, message: "El tipo de publicación seleccionado no es valida."}


    validates :type_pub, inclusion: {in: type_pubs, message: "Tipo de publicacion no valida"}

    def self.items(p)
      paginate(page: p, per_page: 12)
    end

    ###Queries for seaching

    def self.search_publications_by_rg(rg_id)
        select(:id, :name, :type_pub).joins(:research_groups)
                          .where('research_groups.id' => rg_id) if rg_id.present?
    end

    def self.search_publications_by_user(usr_id)
        select(:id, :name, :type_pub).joins(:users)
                          .where('users.id' => usr_id) if usr_id.present?
    end

    def self.search_publications_by_type(type)
        where(type_pub: type) if type.present?
    end

    def self.search_p_by_rg_and_type(rg_id, type)
        search_publications_by_rg(rg_id).search_publications_by_type(type)
    end

    def self.get_research_groups(publication_id)
        return find(publication_id).research_groups.pluck(:id)
    end
    ###Queries for statistics

    def self.num_publications_by_rg(rg_id)
        joins(:research_groups).where('research_groups.id' => rg_id).count if rg_id.present?
    end

    def self.num_publications_by_user(usr_id)
        joins(:users).where('users.id' => usr_id).count if usr_id.present?
    end

    def self.num_publications_by_type(type)
        where(type_pub: type).count if type.present?
    end

    def self.num_publications_by_rg_and_type(rg_id, type)
        joins(:research_groups).where('research_groups.id' => rg_id, type_pub: type).count
    end

end
