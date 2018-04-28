# == Schema Information
#
# Table name: research_subjects
#
#  id         :integer          not null, primary key
#  name       :string(200)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ResearchSubject < ApplicationRecord
  has_many :research_subject_users, dependent: :delete_all
  has_many :users, through: :research_subject_users

  has_many :research_subject_research_groups, dependent: :delete_all
  has_many :research_groups, through: :research_subject_research_groups

  validates :name, presence: { message: Proc.new { ApplicationRecord.presence_msg("nombre") } }
  validates :name, length: { maximum: 200, too_long: "Se permiten máximo %´{count} caracteres para el campo nombre." }

  def self.items(p)
    paginate(page: p, per_page: 12)
  end

  ###Queries for searching

  def self.search_rs_by_rg(rg_id)
    select(:id, :name).joins(:research_groups)
                      .where('research_groups.id' => rg_id) if rg_id.present?
  end

  def self.search_rs_by_name(keywords)
    select(:id, :name).where("name LIKE ?","%#{keywords}%") if keywords.present?
  end

  def self.search_rs_by_user(usr_id)
    select(:id, :name).joins(:users)
                      .where('users.id' => usr_id) if usr_id.present?
  end

  ###Queries for statistics

  def self.num_rs_by_rg(rg_id)
    joins(:research_groups).where('research_groups.id' => rg_id).count if rg_id.present?
  end
  
  def self.num_rs_by_user(usr_id)
    joins(:users).where('users.id' => usr_id).count if usr_id.present?
  end

end
