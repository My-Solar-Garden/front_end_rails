require 'rails_helper'

RSpec.describe 'Garden' do
  it 'exists' do
    attr = {
        "data": {
            "id": "3",
            "type": "garden",
            "attributes": {
                "latitude": 39.75,
                "longitude": -104.996577,
                "name": "The Grove",
                "description": "Corner garden",
                "private": true
            },
            "relationships": {
                "user_gardens": {
                    "data": [
                        {
                            "id": "3",
                            "type": "user_garden"
                        }
                    ]
                },
                "users": {
                    "data": [
                        {
                            "id": "3",
                            "type": "user"
                        }
                    ]
                },
                "sensors": {
                    "data": []
                },
                "garden_plants": {
                    "data": []
                },
                "plants": {
                    "data": []
                }
            }
        }
    }

    garden = Garden.new(attr.deep_symbolize_keys[:data])

    expect(garden).to be_a(Garden)

    expect(garden.id).to be_a(String)
    expect(garden.id).to eq('3')

    expect(garden.name).to be_a(String)
    expect(garden.name).to eq('The Grove')


    expect(garden.latitude).to be_a(Float)
    expect(garden.latitude).to eq(39.75)

    expect(garden.longitude).to be_a(Float)
    expect(garden.longitude).to eq(-104.996577)

    expect(garden.description).to be_a(String)
    expect(garden.description).to eq('Corner garden')

    expect(garden.private).to be_in([true, false])
    expect(garden.private).to eq(true)

    expect(garden.plants).to be_an(Array)
    expect(garden.plants).to eq([])

    expect(garden.sensors).to be_an(Array)
    expect(garden.sensors).to eq([])

    expect(garden.user_ids).to be_an(Array)
    expect(garden.user_ids).to eq(['3'])
  end
end