class CreateResearchSubjectResearchGroups < ActiveRecord::Migration[5.1]
  def change
    create_table :research_subject_research_groups, id: false do |t|
      t.references :research_subject, foreign_key: true
      t.references :research_group, foreign_key: true

      t.timestamps
    end
  end
end
