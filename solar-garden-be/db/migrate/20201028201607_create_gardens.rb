class CreateGardens < ActiveRecord::Migration[5.2]
  def change
    create_table :gardens do |t|
      t.float :latitude
      t.float :longitude
      t.string :name
      t.text :description
      t.timestamps
    end
  end
end
