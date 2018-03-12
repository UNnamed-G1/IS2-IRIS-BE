class CreateEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :events do |t|
<<<<<<< HEAD
      t.integer :id_event
      t.integer :id_group
      t.text :topic
      t.text :description_event
      t.integer :type_event
      t.datetime :date_time
      t.integer :frequence
      t.datetime :end_time_event
=======
      t.references :research_group, foreign_key: true
      t.text :topic, null: false
      t.text :description, null: false
      t.integer :type, null: false #enum
      t.datetime :date, null: false
      t.integer :frequence, null: false #enum
      t.datetime :end_time, null: false
      t.integer :state, null: false #enum
>>>>>>> da0d017d6b98af73f220b6150bb010914eca3ae9

      t.timestamps
    end
  end
end
