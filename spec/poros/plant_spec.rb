require 'rails_helper'

RSpec.describe Plant do
  it "exists" do
    attr = {:data=>{:id=>"212",
    :type=>"plant",
    :attributes=>
     {:image=>"image.url",
      :name=>"Frank Enstein",
      :species=>"some latin malarky",
      :description=>"very plant-like",
      :light_requirements=>"Its a plant, needs a bunch of light yo",
      :water_requirements=>"Its a plant, needs a bunch of water yo",
      :when_to_plant=>"On the 5th new moon of the year",
      :harvest_time=>"When sun is short in the sky and the dark takes over",
      :common_pests=>"buncha lil jerks"},
    :relationships=>{:garden_plants=>{:data=>[]}, :gardens=>{:data=>[]}}}}

    plant = Plant.new(attr[:data])

    expect(plant).to be_a(Plant)
    expect(plant.id).to be_a(String)
    expect(plant.id).to eq(attr[:data][:id])
    expect(plant.image).to be_a(String)
    expect(plant.image).to eq(attr[:data][:attributes][:image])
    expect(plant.image).to eq(attr[:data][:attributes][:image])
    expect(plant.name).to be_a(String)
    expect(plant.name).to eq(attr[:data][:attributes][:name])
    expect(plant.name).to eq(attr[:data][:attributes][:name])
    expect(plant.species).to be_a(String)
    expect(plant.species).to eq(attr[:data][:attributes][:species])
    expect(plant.species).to eq(attr[:data][:attributes][:species])
    expect(plant.description).to be_a(String)
    expect(plant.description).to eq(attr[:data][:attributes][:description])
    expect(plant.description).to eq(attr[:data][:attributes][:description])
    expect(plant.light_requirements).to be_a(String)
    expect(plant.light_requirements).to eq(attr[:data][:attributes][:light_requirements])
    expect(plant.light_requirements).to eq(attr[:data][:attributes][:light_requirements])
    expect(plant.water_requirements).to be_a(String)
    expect(plant.water_requirements).to eq(attr[:data][:attributes][:water_requirements])
    expect(plant.water_requirements).to eq(attr[:data][:attributes][:water_requirements])
    expect(plant.when_to_plant).to be_a(String)
    expect(plant.when_to_plant).to eq(attr[:data][:attributes][:when_to_plant])
    expect(plant.when_to_plant).to eq(attr[:data][:attributes][:when_to_plant])
    expect(plant.harvest_time).to be_a(String)
    expect(plant.harvest_time).to eq(attr[:data][:attributes][:harvest_time])
    expect(plant.harvest_time).to eq(attr[:data][:attributes][:harvest_time])
    expect(plant.common_pests).to be_a(String)
    expect(plant.common_pests).to eq(attr[:data][:attributes][:common_pests])
    expect(plant.common_pests).to eq(attr[:data][:attributes][:common_pests])
    expect(plant.gardens).to be_a(Array)
    expect(plant.gardens).to eq(attr[:data][:relationships][:gardens][:data])
    expect(plant.gardens).to eq(attr[:data][:relationships][:gardens][:data])
  end
end
