class CreateSensors < ActiveRecord::Migration[5.2]
  def change
    create_table :sensors do |t|
      t.references :garden, foreign_key: true
      t.integer :sensor_type
      t.integer :min_threshold
      t.integer :max_threshold
      t.timestamps
    end
  end
end
