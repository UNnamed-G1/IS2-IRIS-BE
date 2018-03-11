class CreateJoinTableUsersPublications < ActiveRecord::Migration[5.1]
  def change
    create_join_table :users, :publications do |t|
      t.references :user, foreign_key: true
      t.references :publication, foreign_key: true
    end
  end
end
