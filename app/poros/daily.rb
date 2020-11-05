class Daily
  attr_reader :temperature,
              :humidity,
              :description

  def initialize(data)
    @temperature = data[:temp][:day]
    @humidity = data[:humidity]
    @description = data[:weather][0][:description]
  end
end
