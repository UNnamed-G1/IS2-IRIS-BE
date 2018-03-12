class CreateResearchSubjectsResearchGroupsJoinTable < ActiveRecord::Migration[5.1]
  def change
    create_join_table :research_groups, :research_subjects do |t|
      t.references :research_group, foreign_key: true
      t.references :research_subject, foreign_key: true
    end
  end
end
