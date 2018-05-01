# == Schema Information
#
# Table name: events
#
#  id                :bigint(8)        not null, primary key
#  research_group_id :bigint(8)
#  name              :string           not null
#  topic             :text             not null
#  description       :text             not null
#  type_ev           :integer          not null
#  date              :datetime         not null
#  frequence         :integer          not null
#  duration          :time             not null
#  state             :integer          not null
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

  enum type_ev: [:privado, :publico]
  enum frequence: [:unico, :repetitivo]
  enum state: [:activo, :inactivo]

  validates :name, presence: {message: Proc.new { ApplicationRecord.presence_msg("nombre") }}
  validates :topic, presence: {message: Proc.new { ApplicationRecord.presence_msg("tema") }}
  validates :description, presence: {message: Proc.new { ApplicationRecord.presence_msg("descripción") }}
  validates :state, presence: {message: Proc.new { ApplicationRecord.presence_msg("estado") }}
  validates :type_ev, presence: {message: Proc.new { ApplicationRecord.presence_msg("tipo de evento") }}
  validates :date, presence: {message: Proc.new { ApplicationRecord.presence_msg("fecha") }}
  validates :frequence, presence: {message: Proc.new { ApplicationRecord.presence_msg("frecuencia") }}
  validates :duration, presence: {message: Proc.new { ApplicationRecord.presence_msg("tiempo de duración") }}
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
      .where("users.id" => usr_id) if usr_id.present?
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

  scope :public_evs, -> { where(type_ev: 1) }

  scope :private_evs_by_user, -> (usr_id) {
            joins(:users)
            .where('users.id': usr_id, type_ev: 0)
        }

  scope :evs_by_author, -> (usr_id) {
          joins(:users)
            .where('users.id': usr_id)
            .merge(EventUser.author)
            .distinct
        }

  scope :evs_by_lider, -> (usr_id) {
          joins(:users, :research_group)
            .merge(
              ResearchGroup
                .joins(:user_research_groups)
                .where('user_research_groups.user_id': usr_id)
                .merge(UserResearchGroup.lider)
            )
            .distinct
        }

  scope :evs_by_editable, -> (usr_id, page) {
          union_scope(evs_by_author(usr_id),
                      evs_by_lider(usr_id))
            .paginate(page: page, per_page: 12)
        }

  scope :evs_by_usr_and_type, -> (usr_id) {
          union_scope(public_evs,
                      private_evs_by_user(usr_id))
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
      type_user_event: "autor"
    )
  end

  def invite_user(user)
    return event_users.create(
      user: user,
      type_user_event: "invitado"
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
    return users.where('event_users.type_user_event': "invitado")
  end

  def get_attendees
    return users.where('event_users.type_user_event': "asistente")
  end

  def get_authors
    return users.where('event_users.type_user_event': "autor")
  end

end
