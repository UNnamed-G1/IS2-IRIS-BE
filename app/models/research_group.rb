# == Schema Information
#
# Table name: research_groups
#
#  id                  :bigint(8)        not null, primary key
#  name                :text             not null
#  description         :text             not null
#  strategic_focus     :text             not null
#  research_priorities :text             not null
#  foundation_date     :date
#  classification      :integer
#  date_classification :date
#  url                 :string
#  state               :integer          not null
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
    has_many :members, class_name: "User", through: :user_research_groups, source: :user
    has_one :photo, as: :imageable

    enum classification: [:A, :B, :C, :D]
    enum state: [:Solicitado, :Aceptado, :Rechazado]

    validates :name, presence: { message: Proc.new { ApplicationRecord.presence_msg("nombre") } }
    validates :description, presence: { message: Proc.new { ApplicationRecord.presence_msg("descripción") } }
    validates :strategic_focus, presence: { message: Proc.new { ApplicationRecord.presence_msg("enfoque estratégico") } }
    validates :research_priorities, presence: { message: Proc.new { ApplicationRecord.presence_msg("prioridades de investigación") } }

    validates :name, length: {maximum: 100, too_long: "Se permiten máximo %{count} caracteres para el campo nombre."}
    validates :description, length: { maximum: 1000, too_long: "Se permiten maximo %{count} caracteres para el campo descripción." }
    validates :strategic_focus, length: { maximum: 1000, too_long: "Se permiten maximo %{count} caracteres para el campo enfoque estratégico." }
    validates :research_priorities, length: { maximum: 1000, too_long: "Se permiten maximo %{count} caracteres para el campo prioridades de investigación." }
    validates :classification, inclusion: { in: classifications, message: "El tipo de clasificación no es válido."}
    validates :state, inclusion: { in: states, message: "El estado seleccionado no es válido."}

    def self.items(p)
      paginate(page: p, per_page: 12).includes(:photo)
    end

    def get_events()
        events.select(:id, :topic, :event_type)
    end

    # QUERIES FOR SEARCHING

    def self.get_rgname_by_id(rg_id)
        where(id: rg_id).name
    end

    def self.get_name_by_publ(publ_id)
      joins(:publications).where('publications.id' => publ_id).pluck(:name) if publ_id.present?
    end

    def self.search_rgs_by_name(keywords)
        select(:id, :name, :description, :classification)
            .where("upper(name) LIKE ?","%#{keywords}%")
            .includes(:photo)
            .order(name: :asc)
    end

    def self.search_rgs_by_class(cl_type)
        select(:id, :name).where(classification: cl_type) if cl_type.present?
    end

    def self.search_rgs_by_dept(dep_id)
        select(:id, :name).joins(:careers)
                          .where('careers.department_id' => dep_id) if dep_id.present?
    end

    def self.news
        select(:name, :description, :updated_at)
            .order(:updated_at)
            .includes(:photo)
            .last(5)
    end

    scope :with_publications_count, -> {
            joins(:publications)
              .select("research_groups.*, COUNT(publications.id) AS pubs_count")
              .order("pubs_count DESC")
              .group("research_groups.id")
          }     
    
    def search_recent_publications
        publications.select(:id, :name, :type_pub, :date)
                                        .where('publications.created_at > ?', 1.week.ago)
                                        .limit(3)
    end

    def member_is_lider?(member)
        m = user_research_groups.find_by(user_id: member.id)
        return m.member_type == "Líder"
    end

    def self.find_by_id(research_group_id)
        return ResearchGroup.find(research_group_id)
    end

    def get_publications
        return publications.select(:id, :name, :publication_type, :date)
    end

    def publications_by_type(type)
        publications.search_publications_by_type(type)
    end

    def add_member(user, member_type)
        if user_research_groups.where(user_id: user.id).any?
            state = UserResearchGroup.states[:Activo]
            type = UserResearchGroup.member_types[member_type]
            sql = "UPDATE user_research_groups SET member_type = #{type}, state = #{state} WHERE user_id = #{id} AND user_id = #{user.id}"
            ActiveRecord::Base.connection.execute(sql)
        else
            return user_research_groups.create(
                joining_date: Date.today.to_s,
                state: :Activo,
                member_type: member_type,  
                user: user,
            )
        end        
    end

    def change_state_user(user_id, state)
        state = UserResearchGroup.states[state]
        sql = "UPDATE user_research_groups SET state = #{state} WHERE user_id = #{user_id} AND research_group_id = #{id}"
        ActiveRecord::Base.connection.execute(sql)
        return user_research_groups.where("user_id": user_id).first
    end

    def change_type_user(user_id, member_type)
        type = UserResearchGroup.member_types[member_type]
        sql = "UPDATE user_research_groups SET member_type = #{type} WHERE user_id = #{user_id} AND research_group_id = #{id}"
        ActiveRecord::Base.connection.execute(sql)
        return user_research_groups.where("user_id": user_id).first
    end

    def remove_user(user)
        return members.delete(user)
    end    

    def search_available_users(keywords)
        types = [UserResearchGroup.member_types[:Miembro], UserResearchGroup.member_types[:Líder]]
        state = UserResearchGroup.states[:Activo]
        users = user_research_groups.where.not("member_type IN (?) AND state = ?", types, state).pluck(:user_id)
        
        return User.search_by_name(keywords).all_except(users).except_admin().limit(10)
    end
end
