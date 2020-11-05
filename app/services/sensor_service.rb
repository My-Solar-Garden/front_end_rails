class SensorService
  def self.new_sensor(sensor_params)
    post_parsed_json("/api/v1/sensors", sensor_params)
  end

  def self.all_sensors_for_garden(params)
    get_parsed_json("/api/v1/gardens/#{params[:id]}/sensors")
  end

  def self.post_parsed_json(url, sensor_params)
    response = conn.post(url) do |req|
      req.params = sensor_params
    end
    JSON.parse(response.body, symbolize_names: true)[:data]
  end

  def self.edit_sensor
    patch_parsed_json("/api/v1/sensors", sensor_params)
  end

  def self.patch_parsed_json(url, sensor_params)
    response = conn.patch(url) do |req|
      req.params = sensor_params
    end
    JSON.parse(response.body, symbolize_names: true)[:data]
  end

  def self.get_parsed_json(url, params= {})
    binding.pry 
    response = conn.get(url) do |req|
      req.params = params
    end
    JSON.parse(response.body, symbolize_names: true)[:data]
  end

  def self.sensor_details(sensor_params)
    # binding.pry
    #this is returning all sensors, need to get it to return only one
    get_parsed_json("/api/v1/sensors/#{sensor_params}")
    # get_parsed_json("/api/v1/gardens/#{sensor_params[:id]}/sensors")

    # get_parsed_json("/api/v1/sensors", sensor_params) #if sensor_params[:id] ==
    #
    # a.select do |sensor|
    #   @selected_sensor = sensor[:id] == sensor_params[:id]
    # end
    # binding.pry
    # get_parsed_json("/api/v1/gardens/#{sensor_params[:id]}/sensors/#{sensor_params[:id]}")
    #
    # get_parsed_json("/api/v1/gardens/#{@selected_sensor[:relationships][:garden][:data][:id]}/sensors/#{sensor_params[:id]}")
  end

  def self.conn
    Faraday.new(url: "#{ENV['BE_URL']}")
  end
end
