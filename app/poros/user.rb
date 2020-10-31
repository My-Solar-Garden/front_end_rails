class User
  attr_reader :id, :email, :gardens

  def initialize(data)
    @id = data[:id]
    @email = data[:attributes][:email]
    @gardens = data[:relationships][:gardens][:data]
  end

  def self.find(user_id)
    # call facade once facade + service pattens implemented
    conn = Faraday.new(url: "https://solar-garden-be.herokuapp.com")
    response = conn.get("/api/v1/users/#{user_id}")
    json = JSON.parse(response.body, symbolize_names: true)
    user = User.new(json[:data])
  end
end
