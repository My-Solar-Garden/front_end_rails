class SessionService
  def self.session_details(auth_hash)
    get_parsed_json("/api/v1/users", auth_hash)
  end

  def self.get_parsed_json(url, auth_hash)
    response = conn.post(url, auth_hash)
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.conn
    Faraday.new(url: "#{ENV['BE_URL']}" )
  end
end
