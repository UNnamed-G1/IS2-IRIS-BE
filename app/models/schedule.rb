# == Schema Information
#
# Table name: schedules
#
#  id         :bigint(8)        not null, primary key
#  start_hour :integer          not null
#  day_week   :integer          not null
#  duration   :integer          default(1), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Schedule < ApplicationRecord
  has_many :schedule_users, dependent: :delete_all
  has_many :users, through: :schedule_users

  enum day_week: [:lunes, :martes, :miercoles, :jueves, :viernes, :sabado, :domingo]

  validates :start_hour, presence: { message: Proc.new { ApplicationRecord.presence_msg("fecha de inicio") } }
  validates :day_week, inclusion: {in: day_weeks, message: "El tipo de día de la semana no es válido."}
  validates :duration, presence: { message: Proc.new { ApplicationRecord.presence_msg("duración") } }

  def self.items(p)
    paginate(page: p, per_page: 12)
  end

  ###Queries for searching

  def self.find_schedules_by_user(usr_id)
    select(:start_hour).joins(:users)
                       .where('users.id' => usr_id) if usr_id.present?

  end

end
