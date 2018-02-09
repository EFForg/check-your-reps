require "rails_helper"

describe "Public access to scores", type: :request do
  let(:congress_member) { FactoryBot.create(:congress_member, 
                                            state: "CA",
                                            district: "14") }

  let(:address) do
    { street: "815 Eddy Street", zipcode: "94109" }
  end

  before(:each) do
    allow(SmartyStreets).to receive(:get_congressional_district).
      with(address[:street], address[:zipcode]).
      and_return([ "CA", "14" ])
  end

  it "gets a scorecard by address" do
    congress_member
    get "/scores/lookup", params: address
    expect(response.status).to eq(200)
  end
end
