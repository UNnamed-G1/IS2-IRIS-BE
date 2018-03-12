class CreateCareersResearchGroupsJoinTable < ActiveRecord::Migration[5.1]
  def change
    create_join_table :careers, :research_groups do |t|
      t.references :career, foreign_key: true
      t.references :research_group, foreign_key: true
    end
  end
end
