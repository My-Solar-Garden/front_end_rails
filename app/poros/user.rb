class User
  attr_reader :id, :email, :gardens
  def initialize(data)
    @id = data[:id]
    @email = data[:attributes][:email]
    @gardens = data[:relationships][:gardens][:data]
  end
end
