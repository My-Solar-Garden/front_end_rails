class CreatePlants < ActiveRecord::Migration[5.2]
  def change
    create_table :plants do |t|
      t.text :image
      t.string :name
      t.string :species
      t.text :description
      t.text :light_requirements
      t.text :water_requirements
      t.text :when_to_plant
      t.text :harvest_time
      t.text :common_pests
      t.timestamps
    end
  end
end
