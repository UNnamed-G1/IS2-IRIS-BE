class CreateEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :events do |t|
      t.integer :id_event
      t.integer :id_group
      t.text :topic
      t.text :description_event
      t.integer :type_event
      t.datetime :date_time
      t.integer :frequence
      t.datetime :end_time_event

      t.timestamps
    end
  end
end
