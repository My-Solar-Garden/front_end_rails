require 'rails_helper'

describe SessionFacade do
  it "should return session details for a user" do
    VCR.use_cassette('google_oauth') do
      params = {id: 2}

# We keep getting this error:
     #  1) SessionFacade should return session details for a user
     # Failure/Error: JSON.parse(response.body, symbolize_names: true)
     #
     # JSON::ParserError:
     #   784: unexpected token at ''
     # ./app/services/session_service.rb:11:in `get_parsed_json'
     # ./app/services/session_service.rb:3:in `session_details'
     # ./app/facades/session_facade.rb:3:in `session_details'
     # ./spec/facades/session_facade_spec.rb:27:in `block (3 levels) in <top (required)>'
     # ./spec/facades/session_facade_spec.rb:5:in `block (2 levels) in <top (required)>'

# Below is what we have attempted and neither one has been working
      # omniauth = {
      #     provider: 'google_oauth2',
      #     uid: '100000000000000000000',
      #     info: {
      #         name: 'John Smith',
      #         email: 'john@example.com',
      #         first_name: 'John',
      #         last_name: 'Smith',
      #         image: 'https://lh4.googleusercontent.com/photo.jpg',
      #         urls: {
      #             google: 'https://plus.google.com/+JohnSmith'
      #         }
      #     },
      #     credentials: {
      #         token: 'MOCK_OMNIAUTH_GOOGLE_TOKEN',
      #         refresh_token: 'MOCK_OMNIAUTH_GOOGLE_REFRESH TOKEN',
      #         expires_at: DateTime.now,
      #         expires: true
      #     },
      # }

      # user = SessionFacade.session_details(params, stub_omniauth)
      # user = SessionFacade.session_details(params, omniauth)

      expect(user).to be_a(User)
    end
  end
end
