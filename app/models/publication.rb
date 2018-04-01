# == Schema Information
#
# Table name: publications
#
#  id                :integer          not null, primary key
#  name              :string(255)      not null
#  date              :date             not null
#  abstract          :text             not null
#  url               :string(300)      not null
#  brief_description :string(500)      not null
#  file_name         :string(300)
#  type_pub          :integer          not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class Publication < ApplicationRecord
    has_many :publication_research_groups
    has_many :research_groups, through: :publication_research_groups
    has_many :publication_users
    has_many :users, through: :publication_users

    enum type_pub: [:software, :articulo, :tesis, :libro, :monografia, :patente]

    validates :name, :date, :abstract, :url, :brief_description, :type_pub, presence: true
    validates :name, length: { maximum: 255, too_long: "Se permiten maximo %{count} caracteres" }
    validates :url, :file_name, length: { maximum: 300, too_long: "Se permiten maximo %{count} caracteres" }
    validates :brief_description, length: { maximum: 500, too_long: "Se permiten maximo %{count} caracteres" }
    validates :type_pub, inclusion: {in: type_pubs.keys, message: "Tipo de publicacion no valida"}
    
    def self.search_publications_by_research_group(group_id)
        select(:id, :name).joins(:research_groups)
                          .where('research_groups.id': group_id) if group_id.present?
    end
    
    def self.search_publications_by_type(type)
        where(type_pub: type)
    end
    
    def self.search_p_by_rg_and_type(group_id, type)
        search_publications_by_research_group(group_id).search_publications_by_type(type)
    end    
end
