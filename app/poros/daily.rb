class Daily
  attr_reader :date,
              :temperature,
              :humidity,
              :description

  def initialize(data)
    @date = data[:dt]
    @temperature = data[:temp][:day]
    @humidity = data[:humidity]
    @description = data[:weather][0][:description].titleize
  end
end
