# == Schema Information
#
# Table name: publications
#
#  id                :bigint(8)        not null, primary key
#  name              :text             not null
#  date              :date             not null
#  abstract          :text             not null
#  document          :text
#  brief_description :string(500)      not null
#  publication_type  :integer          not null
#  distinction_type  :integer          not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class Publication < ApplicationRecord
    has_many :publication_research_groups, dependent: :delete_all
    has_many :research_groups, through: :publication_research_groups
    has_many :publication_users, dependent: :delete_all
    has_many :users, through: :publication_users

    mount_uploader :document, DocumentUploader

    enum publication_type: [:Software, :Artículo, :Tesis, :Libro, :Monografía, :Patente]
    enum distinction_type: [:Ninguna, :Meritoria, :Laureada]

    validates :name, presence: { message: Proc.new { ApplicationRecord.presence_msg("nombre") } }
    validates :date, presence: { message: Proc.new { ApplicationRecord.presence_msg("fecha") } }
    validates :abstract, presence: { message: Proc.new { ApplicationRecord.presence_msg("abstract") } }
    validates :brief_description, presence: { message: Proc.new { ApplicationRecord.presence_msg("descripción breve") } }
    validates :publication_type, presence: { message: Proc.new { ApplicationRecord.presence_msg("tipo de publicación") } }
    validates :brief_description, length: { maximum: 500, too_long: "Se permiten maximo %{count} caracteres para el campo descripción breve." }
    validates :publication_type, inclusion: {in: publication_types, message: "El tipo de publicación seleccionado no es valida."}
    validates :distinction_type, presence: {message: Proc.new { ApplicationRecord.presence_msg("tipo de distinción") } }
    validates :distinction_type, inclusion: {in: distinction_types, message: "El tipo de distinción seleccionado no es valida."}    

    def self.items(p)
      paginate(page: p, per_page: 12)
    end

    # QUERIES FOR SEARCHING

    def self.search_publications_by_name(keywords)
        select(:id, :name, :publication_type, :abstract).where("upper(name) LIKE ?","%#{keywords}%").order(name: :asc)
    end 
    
    def self.search_publications_by_type(type)
        where(publication_type: publication_types[type])
    end

    def self.get_research_groups(publication_id)
        return find(publication_id).research_groups.pluck(:id)
    end

    ###Queries for statistics

    def self.num_publications_by_rg(rg_id)
        joins(:research_groups).where('research_groups.id' => rg_id).count if rg_id.present?
    end
    
    def self.num_publications_by_user_in_a_period(usr_id)
        joins(:users).where('users.id' => usr_id)
                     .group_by_period(:month, :date, range: 6.months.ago..Time.now, time_zone: "Bogota").count
    end

    def self.num_publications_by_rg_in_a_period(rg_id)
        joins(:research_groups).where('research_groups.id' => rg_id)
                     .group_by_period(:month, :date, range: 6.months.ago..Time.now, time_zone: "Bogota").count
    end

    def self.num_publications_by_user_and_type(usr_id, type)
        joins(:users).where('users.id' => usr_id, publication_type: type).count
    end

    def self.num_publications_by_type(type)
        where(publication_type: type).count if type.present?
    end

    def self.num_publications_in_a_period_by_rg(rg_id, period)#3 or 6 months
        joins(:research_groups).where('research_groups.id = ? AND publications.created_at > ?', rg_id , period.months.ago).count
    end
    
    def self.num_publications_in_a_period_by_user(user_id, period)#3 or 6 months
        joins(:users).where('users.id = ? AND publications.created_at > ?', user_id , period.months.ago).count
    end 
    
    def self.num_publications_by_rg_and_type(rg_id, type)
        joins(:research_groups).where('research_groups.id' => rg_id, publication_type: type).count
    end

    def self.num_meritorious_publications_by_user(usr_id)
        joins(:users).where('users.id = ? AND publications.distinction_type = ?', usr_id, 1)
                     .count if usr_id.present?
    end

    def self.num_laureate_publications_by_user(usr_id)
        joins(:users).where('users.id = ? AND publications.distinction_type = ?', usr_id, 2)
                     .count if usr_id.present?
    end
    
    def self.num_undistincted_publications_by_user(usr_id)
        joins(:users).where('users.id = ? AND publications.distinction_type = ?', usr_id, 0)
                     .count if usr_id.present?
    end       
end
