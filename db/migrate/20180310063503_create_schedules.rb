class CreateSchedules < ActiveRecord::Migration[5.1]
  def change
    create_table :schedules do |t|
      t.datetime :start_date, null: false
      t.datetime :end_date, null: false

      t.timestamps
    end
  end
end
