class CreateUsersResearchSubjectsJoinTable < ActiveRecord::Migration[5.1]
  def change
    create_join_table :users, :research_subjects do |t|
      t.index :user_id
      t.index :research_subject_id
    end
  end
end
