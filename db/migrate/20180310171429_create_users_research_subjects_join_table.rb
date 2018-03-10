class CreateUsersResearchSubjectsJoinTable < ActiveRecord::Migration[5.1]
  def change
    create_join_table :users, :research_subjects do |t|
      t.references :user, index: true, foreign_key: true
      t.references :research_subject, index: true, foreign_key: true
    end
  end
end
