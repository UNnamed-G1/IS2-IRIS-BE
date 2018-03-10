class CreateResearchSubjects < ActiveRecord::Migration[5.1]
  def change
    create_table :research_subjects do |t|
      t.string :name, limit: 100

      t.timestamps
    end
  end
end
