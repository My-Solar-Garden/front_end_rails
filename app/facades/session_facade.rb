class SessionFacade
  def self.session_details(params, auth_hash)
    parsed_json = SessionService.session_details(params, auth_hash)
    session(parsed_json)
  end

  def self.session(data)
    User.new(data[:data])
  end
end
