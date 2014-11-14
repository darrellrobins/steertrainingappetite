class CreatePubs < ActiveRecord::Migration
  def change
    create_table :pubs do |t|
      t.string :name
      t.string :website
      t.text :description
      t.float :latitude
      t.float :longitude
      t.float :rating
      t.text :address

      t.timestamps
    end
  end
end
