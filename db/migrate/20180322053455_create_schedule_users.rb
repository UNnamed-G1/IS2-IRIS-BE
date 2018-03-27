class CreateScheduleUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :schedule_users do |t|
      t.references :user, index: true, foreign_key: true
      t.references :schedule, index: true, foreign_key: true

      t.timestamps
    end
  end
end
