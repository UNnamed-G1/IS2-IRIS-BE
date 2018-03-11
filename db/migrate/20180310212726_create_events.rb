class CreateEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :events do |t|
      t.references :research_group, foreign_key: true
      t.text :topic, null: false
      t.text :description_event, null: false
      t.integer :type_event, null: false #enum
      t.datetime :date_event, null: false
      t.integer :frequence, null: false #enum
      t.datetime :end_time_event, null: false
      t.integer :event_state, null: false #enum

      t.timestamps
    end
  end
end
