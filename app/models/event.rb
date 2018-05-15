# == Schema Information
#
# Table name: events
#
#  id                :bigint(8)        not null, primary key
#  research_group_id :bigint(8)
#  name              :string           not null
#  topic             :text             not null
#  description       :text             not null
#  event_type        :integer          not null
#  date              :datetime         not null
#  frequence         :integer          not null
#  duration          :time             not null
#  state             :integer          not null
#  latitude          :float
#  longitude         :float
#  address           :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
# Indexes
#
#  index_events_on_research_group_id  (research_group_id)
#
# Foreign Keys
#
#  fk_rails_...  (research_group_id => research_groups.id)
#

class Event < ApplicationRecord
  include ActiveRecord::UnionScope

  has_many :event_users, dependent: :delete_all
  has_many :users, through: :event_users
  has_many :photos, as: :imageable
  belongs_to :research_group

  enum event_type: [:Privado, :Público]
  enum frequence: ["Único", :Repetitivo]
  enum state: [:Activo, :Inactivo]

  validates :name, presence: {message: Proc.new { ApplicationRecord.presence_msg("nombre") }}
  validates :topic, presence: {message: Proc.new { ApplicationRecord.presence_msg("tema") }}
  validates :description, presence: {message: Proc.new { ApplicationRecord.presence_msg("descripción") }}
  validates :state, presence: {message: Proc.new { ApplicationRecord.presence_msg("estado") }}
  validates :event_type, presence: {message: Proc.new { ApplicationRecord.presence_msg("tipo de evento") }}
  validates :date, presence: {message: Proc.new { ApplicationRecord.presence_msg("fecha") }}
  validates :frequence, presence: {message: Proc.new { ApplicationRecord.presence_msg("frecuencia") }}
  validates :duration, presence: {message: Proc.new { ApplicationRecord.presence_msg("tiempo de duración") }}
  validates :event_type, inclusion: {in: event_types, message: "El tipo de evento seleccionado no es valido."}
  validates :frequence, inclusion: {in: frequences, message: "El tipo de evento seleccionada no es valida."}
  validates :state, inclusion: {in: states, message: "El estado seleccionado no es valido."}

  def self.items(p)
    paginate(page: p, per_page: 12)
  end

  def self.get_group_id(event_id)
    return self.find(event_id).research_group_id
  end

  def is_public?
    return event_type == "Público"
  end

  def is_private?
    return event_type == "Privado"
  end

  # QUERIES FOR SEARCHING

  def self.search_events_by_name(keywords)
    return select(:id, :name, :event_type, :topic, :description, :state)
            .where("upper(name) LIKE ? AND event_type = ? AND state = ?","%#{keywords}%", event_types[:Público], states[:Activo])
            .order(name: :asc)
  end

  def self.search_events_by_state(status)
    select(:id, :topic, :event_type).where(state: status) if status.present?
  end

  def self.search_events_by_freq(freq)
    select(:id, :topic, :event_type).where(frequence: freq) if freq.present?
  end

  def self.search_events_by_type(type)
    select(:id, :topic, :event_type).where(event_type: type) if type.present?
  end

  scope :public_evs, -> { where(event_type: 1) }

  scope :private_evs_by_user, -> (user_id) {
            joins(:users)
            .where('users.id': user_id, event_type: 0)
        }

  scope :evs_by_author, -> (user_id) {
          joins(:users)
            .where('users.id': user_id)
            .merge(EventUser.Autor)
            .distinct
        }

  scope :evs_by_lider, -> (user_id) {
          joins(:users, :research_group)
            .merge(
              ResearchGroup
                .joins(:user_research_groups)
                .where('user_research_groups.user_id': user_id)
                .merge(UserResearchGroup.Líder)
            )
            .distinct
        }

  scope :editable_events, -> (user_id, page) {
          union_scope(evs_by_author(user_id),
                      evs_by_lider(user_id))
            .paginate(page: page, per_page: 12)
        }

  scope :evs_by_usr_and_type, -> (user_id) {
          union_scope(public_evs,
                      private_evs_by_user(user_id))
        }

  def self.news
    select(:topic, :description, :date).order(:date).first(3)
  end

  def self.get_research_group_id(event_id)
      event = Event.find(event_id)
      return event.research_group.id
  end

  def self.get_by_id(event_id)
    return Event.find(event_id)
  end

  def add_author(user)
    return event_users.create(
      user: user,
      type_user_event: "Autor"
    )
  end

  def invite_user(user)
    return event_users.create(
      user: user,
      type_user_event: "Invitado"
    )
  end

  def delete_user(user)
    return users.delete(user)
  end

  def change_user_as_attendee(user)
    sql = "UPDATE event_users SET type_user_event = 1 WHERE user_id = #{user.id} AND event_id = #{id}"
    ActiveRecord::Base.connection.execute(sql)
    return event_users.where("user_id": user.id).first
  end

  def get_invited_users
    return users.where('event_users.type_user_event': "Invitado")
  end

  def get_attendees
    return users.where('event_users.type_user_event': "Asistente")
  end

  def get_authors
    return users.where('event_users.type_user_event': "Autor")
  end

end
