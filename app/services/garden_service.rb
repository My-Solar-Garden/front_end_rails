class GardenService
  def self.garden_details(params)
    get_parsed_json("api/v1/gardens/#{params[:id]}")
  end

  def self.new_garden(params, current_user_id)
    response = conn.post("api/v1/gardens") do |req|
      req.params = params
      req.params[:user_id] = current_user_id
    end
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.get_parsed_json(url, params = {})
    response = conn.get(url) do |req|
      req.params = params
    end
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.conn
    Faraday.new(url: 'https://solar-garden-be.herokuapp.com/')
  end
end
