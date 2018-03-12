class CreateSchedules < ActiveRecord::Migration[5.1]
  def change
    create_table :schedules do |t|
<<<<<<< HEAD
      t.datetime :start
      t.datetime :end
=======
      t.datetime :start, null: false
      t.datetime :end, null: false
>>>>>>> da0d017d6b98af73f220b6150bb010914eca3ae9

      t.timestamps
    end
  end
end
