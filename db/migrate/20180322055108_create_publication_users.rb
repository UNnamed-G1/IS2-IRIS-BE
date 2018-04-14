class CreatePublicationUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :publication_users do |t|
      t.references :user, foreign_key: true
      t.references :publication, foreign_key: true

      t.timestamps
    end
  end
end
