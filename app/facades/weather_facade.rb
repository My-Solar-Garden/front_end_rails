class WeatherFacade
  def self.create_weather_objects(weather_params)
    parsed_json = WeatherService.new_weather(weather_params)
    weather(parsed_json)
  end

  def self.weather(data)
    Weather.new(data)
  end
end
