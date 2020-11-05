class Weather
  attr_reader :temperature,
              :humidity,
              :description,
              :daily
  def initialize(data)
    @temperature = data[:current][:temp]
    @humidity = data[:current][:humidity]
    @description = data[:current][:weather][0][:description].titleize
    @daily = eight_day_forecast(data[:daily])
  end

  def eight_day_forecast(data)
    data.map do |day|
      DailyForecast.new(day)
    end
  end
end
