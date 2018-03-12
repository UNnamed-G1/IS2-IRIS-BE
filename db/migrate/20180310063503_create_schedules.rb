class CreateSchedules < ActiveRecord::Migration[5.1]
  def change
    create_table :schedules do |t|
      t.datetime :start, null: false
      t.datetime :end, null: false

      t.timestamps
    end
  end
end
