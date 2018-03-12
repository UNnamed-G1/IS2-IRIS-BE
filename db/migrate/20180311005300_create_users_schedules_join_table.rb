class CreateUsersSchedulesJoinTable < ActiveRecord::Migration[5.1]
  def change
    create_join_table :users, :schedules do |t|
      t.references :user, index: true, foreign_key: true
      t.references :schedule, index: true, foreign_key: true
    end
  end
end
