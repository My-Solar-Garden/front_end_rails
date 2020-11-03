class SessionService
  def self.session_details(params, auth_hash)
    get_parsed_json("api/v1/users/#{params[:id]}", auth_hash)
  end

  def self.get_parsed_json(url, auth_hash, params = {})
    response = conn.post(url, auth_hash) do |req|
      req.params = params
    end
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.conn
    Faraday.new(url: 'https://solar-garden-be.herokuapp.com/' )
  end
end
