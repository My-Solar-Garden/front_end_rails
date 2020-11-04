class UserService
  def self.conn
    Faraday.new(ENV['BE_URL'])
  end

  def self.update_email(id, email)
    conn.patch("/api/v1/users/#{id}") do |req|
      req.headers['CONTENT_TYPE'] = "application/json"
      req.params['id'] = id
      req.params['update_user'] = { email: email }
    end
  end

  def self.delete_user(id)
    conn.delete("/api/v1/users/#{id}")
  end
end
