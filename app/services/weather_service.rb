class WeatherService
  def self.new_weather(weather_params)
    post_parsed_json("/api/v1/forecast", weather_params)
  end

  def self.post_parsed_json(url, params= {})
    lat = params[0]
    lon = params[1]
    response = Faraday.get(ENV['WEATHER_URL']) do |f|
      f.params['appid'] = ENV['OPEN_WEATHER_API_KEY']
      f.params['lat'] = lat
      f.params['lon'] = lon
      f.params['exclude'] = 'minutely,hourly'
      f.params['units'] = 'imperial'
    end
    JSON.parse(response.body, symbolize_names: true)
  end
end
