class Garden
  attr_reader :id,
              :name,
              :latitude,
              :longitude,
              :description,
              :is_private,
              :plants,
              :sensors,
              :user_ids

  def initialize(data)
    @id = data[:id]
    @name = data[:attributes][:name]
    @latitude = data[:attributes][:latitude]
    @longitude = data[:attributes][:longitude]
    @description = data[:attributes][:description]
    @is_private = data[:attributes][:private]
    @plants = set_plants(data)
    @sensors = set_sensors(data)
    @user_ids = set_users(data)
  end

  def set_plants(data)
    data[:relationships][:plants][:data] rescue nil
  end

  def set_sensors(data)
    data[:relationships][:sensors][:data] rescue nil
  end

  def set_users(data)
    data[:relationships][:users][:data].map {|user| user[:id]}
  end
end
