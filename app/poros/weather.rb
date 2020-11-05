class Weather
  attr_reader :temperature,
              :humidity,
              :description,
              :daily

  def initialize(data)
    @temperature = data[:data][:attributes][:temperature]
    @humidity = data[:data][:attributes][:humidity]
    @description = data[:data][:attributes][:description].titleize
    @daily = eight_day_forecast(data[:data][:attributes][:daily])
  end

  def eight_day_forecast(data)
    data.map do |day|
      DailyForecast.new(day)
    end
  end
end
