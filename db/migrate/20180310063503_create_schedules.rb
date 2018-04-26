class CreateSchedules < ActiveRecord::Migration[5.1]
  def change
    create_table :schedules do |t|
      t.integer :start_hour, null: false
      t.integer :day_week, null: false
      t.integer :duration, null: false, default: 1

      t.timestamps
    end
  end
end
