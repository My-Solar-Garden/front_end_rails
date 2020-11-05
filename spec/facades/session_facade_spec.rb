require 'rails_helper'

describe SessionFacade do
  it "should return session details for a user" do
    user = SessionFacade.session_details(stub_omniauth)

    expect(user).to be_a(User)
  end

  it "should generate session poros" do
    data = {:data=>
                    {
                     :id=>"1",
                     :type=>"garden",
                     :attributes=>{
                                   :email=> "big_tacos@tacos.com"
                                  },
                     :relationships=>{
                                    :gardens=>{
                                               :data=>[ ]
                                               }
                                      }
                    }
            }

    user = SessionFacade.session(data)
  end
end
