class CreateJoinTablePhotosEvents < ActiveRecord::Migration[5.1]
  def change
    create_join_table :photos, :events do |t|
      t.references :photo, foreign_key: true
      t.references :event, foreign_key: true
    end
  end
end
