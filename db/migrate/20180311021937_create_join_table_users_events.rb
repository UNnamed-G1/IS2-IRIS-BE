class CreateJoinTableUsersEvents < ActiveRecord::Migration[5.1]
  def change
    create_join_table :users, :events do |t|
      t.references :user, foreign_key: true
      t.references :event, foreign_key: true
    end
  end
end
