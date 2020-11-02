require 'rails_helper'

describe "Plant poro" do
  it "can exist" do
   data = {  "id": 18,
            "name": "Onion",
            "description": "Onions are a cold-season crop, easy to grow because of their hardiness. We recommend using onion sets, which can be planted without worry of frost damage and have a higher success rate than direct seed or transplants. Onions grow well on raised beds or raised rows at least 4 inches high.",
            "optimal_sun": "Full Sun(at least 6 hours a day)",
            "optimal_soil": "Neutral pH",
            "planting_considerations": "Select a location with full sun where your onions won't be shaded by other plants. Soil needs to be well-drained, loose, and rich in nitrogen; compact soil affects bulb development.",
            "when_to_plant": "Plant onions as soon as the ground can be worked in the spring, usually late March or April. Make sure temperature doesn’t go below 20 degrees F.",
            "growing_from_seed": "Seeding? Onion seeds are short-lived. If planting seeds indoors, start with fresh seeds each year. Start seeds indoors about 6 weeks before transplanting.",
            "transplanting": "Think of onions as a leaf crop, not a root crop. When planting onion sets, don’t bury them more than one inch under the soil; if more than the bottom third of the bulb is underground, bulb growth can be restricted.",
            "spacing": "Final spacing should be 4-5 inches between each plant and in rows 12-18 inches apart.",
            "watering": "Generally, onions do not need consistent watering if mulch is used. About one inch of water per week (including rain water) is sufficient. If you want sweeter onions, water more. Onions will look healthy even if they are bone dry, be sure to water during drought conditions.",
            "feeding": "Fertilize every few weeks with nitrogen to get big bulbs. Cease fertilizing when the onions push the soil away and the bulbing process has started. Do not put the soil back around the onions; the bulb needs to emerge above the soil.",
            "other_care": "Make sure soil is well-drained. Mulch will help retain moisture and stifle weeds. Cut or pull any onions that send up flower stalks; this means that the onions have “bolted” and are done. When onions start to mature, the tops become yellow and begin to fall over. At that point, bend the tops down or even stomp on them to speed the final ripening process.",
            "diseases": "n/a",
            "pests": "Onion Maggots",
            "harvesting": "When tops are brown, pull the onions. Be sure to harvest in late summer, before cool weather. Mature onions may spoil in fall weather.",
            "storage_use": "Allow onions to dry for several weeks before you store them in a root cellar or any other storage area. Spread them out on an open screen off the ground to dry. Store at 40 to 50 degrees F (4 to 10 degrees C) in braids or with the stems broken off. Mature, dry-skinned bulbs like it cool and dry, so don't store them with apples or potatoes.",
            "image_url": "harvest_helper_production/18_onion"
          }
    plant = PlantPoro.new(data)
    expect(plant).to be_a PlantPoro
    expect(plant.id).to eq(data[:id])
    expect(plant.name).to eq(data[:name])
    expect(plant.description).to eq(data[:description])
    expect(plant.light_requirements).to eq(data[:optimal_sun])
    expect(plant.water_requirements).to eq(data[:watering])
    expect(plant.when_to_plant).to eq(data[:when_to_plant])
    expect(plant.harvest_time).to eq(data[:harvesting])
    expect(plant.common_pests).to eq(data[:pests])
  end
end