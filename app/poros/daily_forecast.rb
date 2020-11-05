class DailyForecast
  attr_reader :date,
              :temperature,
              :humidity,
              :description

  def initialize(data)
    @date = formatted_date(data[:date])
    @temperature = data[:temperature]
    @humidity = data[:humidity]
    @description = data[:description].titleize
  end

  def formatted_date(date)
    date.split("T")[0]
  end
end
