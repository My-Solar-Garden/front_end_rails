class SessionFacade
  def self.session_details(auth_hash)
    session_response = SessionService.session_details(auth_hash)
    session(session_response)
  end

  def self.session(session_response)
    User.new(session_response[:data])
  end
end
