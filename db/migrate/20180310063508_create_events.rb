class CreateEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :events do |t|
      t.references :research_group, foreign_key: true
      t.text :topic, null: false
      t.text :description, null: false
      t.integer :type_ev, null: false #enum
      t.datetime :date, null: false
      t.integer :frequence, null: false #enum
      t.datetime :end_time, null: false
      t.integer :state, null: false #enum

      t.timestamps
    end
  end
end
