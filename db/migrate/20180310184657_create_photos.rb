class CreatePhotos < ActiveRecord::Migration[5.1]
  def change
    create_table :photos do |t|
      t.text :link
      t.integer :type_imageable

      t.timestamps
    end
  end
end
