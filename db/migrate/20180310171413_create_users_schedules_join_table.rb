class CreateUsersSchedulesJoinTable < ActiveRecord::Migration[5.1]
  def change
    create_join_table :users, :schedules do |t|
      t.index :user_id
      t.index :schedule_id
    end
  end
end
