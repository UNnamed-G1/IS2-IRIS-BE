class CreateEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :events do |t|
      t.references :research_group, foreign_key: true
      t.string :name, null: false
      t.text :topic, null: false
      t.text :description, null: false
      t.integer :event_type, null: false #enum
      t.datetime :date, null: false
      t.integer :frequence, null: false #enum
      t.time :duration, null: false
      t.integer :state, null: false #enum
      t.float :latitude
      t.float :longitude
      t.string :address

      t.timestamps
    end
  end
end
