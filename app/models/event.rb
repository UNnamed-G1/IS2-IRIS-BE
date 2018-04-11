# == Schema Information
#
# Table name: events
#
#  id                :integer          not null, primary key
#  research_group_id :integer
#  topic             :text             not null
#  description       :text             not null
#  type_ev           :integer          not null
#  date              :datetime         not null
#  frequence         :integer          not null
#  end_time          :datetime         not null
#  state             :integer          not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
# Indexes
#
#  index_events_on_research_group_id  (research_group_id)
#

class Event < ApplicationRecord
    has_many :event_users, dependent: :delete_all
    has_many :users, through: :event_users
    has_many :photos, as: :imageable
    belongs_to :research_group

    enum type_ev: [:privado, :publico]
    enum frequence: [:unico, :repetitivo]
    enum state: [:activo, :inactivo]

    validates :topic, presence: { message: Proc.new { ApplicationRecord.presence_msg("tema") } }
    validates :description, presence: { message: Proc.new { ApplicationRecord.presence_msg("descripción") } }
    validates :state, presence: { message: Proc.new { ApplicationRecord.presence_msg("estado") } }
    validates :type_ev, presence: { message: Proc.new { ApplicationRecord.presence_msg("tipo de evento") } }
    validates :date, presence: { message: Proc.new { ApplicationRecord.presence_msg("fecha") } }
    validates :frequence, presence: { message: Proc.new { ApplicationRecord.presence_msg("frecuencia") } }
    validates :end_time, presence: { message: Proc.new { ApplicationRecord.presence_msg("hora de finalización") } }
    validates :type_ev, inclusion: {in: type_evs, message: "El tipo de evento seleccionado no es valido."}
    validates :frequence, inclusion: {in: frequences, message: "El tipo de evento seleccionada no es valida."}
    validates :state, inclusion: {in: states, message: "El estado seleccionado no es valido."}

    def self.items(p)
      paginate(page: p, per_page: 12)
    end

    def self.get_group_id(event_id)
        return self.find(event_id).research_group_id
    end

    def is_public?
        return type_ev == "publico"
    end

    def is_private?
        return type_ev == "private"
    end

    ###Queries for searching

    def self.search_events_by_rg(ev_id)
        select(:id, :topic, :type_ev).where(research_group_id: ev_id) if ev_id.present?
    end

    def self.search_events_by_user(usr_id)
        select(:id, :topic, :type_ev).joins(:users)
                                            .where('users.id' => usr_id) if usr_id.present?
    end

    def self.search_events_by_state(status)
        select(:id, :topic, :type_ev).where(state: status) if status.present?
    end

    def self.search_events_by_freq(freq)
        select(:id, :topic, :type_ev).where(frequence: freq) if freq.present?
    end

    def self.search_events_by_type(type)
        select(:id, :topic, :type_ev).where(type_ev: type) if type.present?
    end

    scope :public_evs, ->{select(:id, :topic, :type_ev, :description, :date, :frequence, :end_time, :state, :research_group_id).where(type_ev: 1)}

    scope :private_evs_by_user, -> (usr_id){select(:id, :topic, :type_ev, :description, :date, :frequence, :end_time, :state, :research_group_id)
                                            .joins(:users)
                                            .where('users.id': usr_id, type_ev: 0)}

    def self.evs_by_usr_and_type(usr_id)
        public_evs + private_evs_by_user(usr_id)
    end

    def self.news
        select(:topic, :description, :date).order(:date).first(3)
    end
end
