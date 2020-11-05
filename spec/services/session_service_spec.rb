require 'rails_helper'

describe SessionService do
  it "returns details data" do
    response = SessionService.session_details(stub_omniauth)
    user_details_response_structure_check(response)
  end
end
