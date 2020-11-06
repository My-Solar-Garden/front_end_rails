class WeatherService
  def self.new_weather(weather_params)
    post_parsed_json("/api/v1/forecast", weather_params)
  end

  def self.post_parsed_json(url, params= {})
    lat = params[0]
    lon = params[1]
    response = conn.get(url) do |f|
      f.params['lat'] = lat
      f.params['lon'] = lon
    end
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.conn
    Faraday.new(url: ENV['BE_URL'])
  end
end
