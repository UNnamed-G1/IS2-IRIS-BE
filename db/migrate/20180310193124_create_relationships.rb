class CreateRelationships < ActiveRecord::Migration[5.1]
  def change
    create_table :relationships, id: false do |t|
      t.integer :followed_id, index: true, foreign_key: true
      t.integer :follower_id, index: true, foreign_key: true

      t.timestamps
    end
    add_index :relationships, [:follower_id, :followed_id], unique: true
  end
end
