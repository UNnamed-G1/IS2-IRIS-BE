class CreateResearchSubjectUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :research_subject_users, id: false do |t|
      t.references :user, foreign_key: true
      t.references :research_subject, foreign_key: true

      t.timestamps
    end
  end
end
