class DailyForecast
  attr_reader :date,
              :temperature,
              :humidity,
              :description

  def initialize(data)
    @date = formatted_date(data[:dt])
    @temperature = data[:temp][:day]
    @humidity = data[:humidity]
    @description = data[:weather][0][:description].titleize
  end

  def formatted_date(iso)
    Time.at(iso).to_s.split(" ")[0]
  end
end
