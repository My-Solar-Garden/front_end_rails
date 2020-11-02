class CreateGardenHealths < ActiveRecord::Migration[5.2]
  def change
    create_table :garden_healths do |t|
      t.references :sensor, foreign_key: true
      t.integer :reading_type
      t.float :reading
      t.datetime :time_of_reading
      t.timestamps
    end
  end
end
