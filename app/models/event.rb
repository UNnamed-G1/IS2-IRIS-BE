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
    has_many :event_users
    has_many :users, through: :event_users
    has_many :photos, as: :imageable
    belongs_to :research_group

    enum type_ev: [:privado, :publico]
    enum frequence: [:unico, :repetitivo]
    enum state: [:activo, :inactivo]

    validates :topic, :description, :state, presence: true
    validates :type_ev, :date, :frequence, :end_time, presence: true
    validates :type_ev, inclusion: {in: type_evs, message: "Tipo de evento invalido."}
    validates :frequence, inclusion: {in: frequences, message: "Frecuencia del evento invalida."}
    validates :state, inclusion: {in: states, message: "Estado del evento invalido."}

    def self.get_group_id(event_id)
        return Event.find(event_id).research_group_id
    end

    def is_public?
        return type_ev == "publico"
    end

    def is_private?
        return type_ev == "private"
    end
    
    ###Queries for searching
    
    def self.search_events_by_rg(ev_id)
        select(:id, :name, :topic, :type_ev).where(research_group_id: ev_id) if ev_id.present?
    end
    
    def self.search_events_by_user(usr_id)
        select(:id, :name, :topic, :type_ev).joins(:users)
                                            .where('users.id' => usr_id) if usr_id.present?
    end 
    
    def self.search_events_by_state(status)
        select(:id, :name, :topic, :type_ev).where(state: status) if status.present?
    end
    
    def self.search_events_by_freq(freq)
        select(:id, :name, :topic, :type_ev).where(frequence: freq) if freq.present?
    end
    
    def self.search_events_by_type(type)
        select(:id, :name, :topic, :type_ev).where(type_ev: type) if type.present?
    end
    
    scope :public_evs, ->{select(:id, :name, :topic, :type_ev, :description, :date, :frequence, :end_time, :state, :research_group_id).where(type_ev: 1)}
        
    scope :private_evs_by_user, -> (usr_id){select(:id, :name, :topic, :type_ev, :description, :date, :frequence, :end_time, :state, :research_group_id)
                                            .joins(:users)
                                            .where('users.id': usr_id, type_ev: 0)}    
    
    def self.evs_by_usr_and_type(usr_id)
        public_evs + private_evs_by_user(usr_id)
    end    
    
    def self.news
        self.order(:date).first(3)
    end 
end
