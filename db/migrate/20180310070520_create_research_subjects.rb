class CreateResearchSubjects < ActiveRecord::Migration[5.1]
  def change
    create_table :research_subjects do |t|
<<<<<<< HEAD
      t.string :name, limit: 100
=======
      t.string :name, limit: 200
>>>>>>> da0d017d6b98af73f220b6150bb010914eca3ae9

      t.timestamps
    end
  end
end
