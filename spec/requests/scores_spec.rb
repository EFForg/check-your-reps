require "rails_helper"

describe "Public access to scores", type: :request do
  let(:score) do
    FactoryBot.create(:score, congress_member: FactoryBot.create(:senator,
                                                                 state: "CA"))
  end

  let(:address) do
    { street: "815 Eddy Street", zipcode: "94109" }
  end

  before(:each) do
    score

    allow(SmartyStreets).to receive(:get_congressional_district).
      with(address[:street], address[:zipcode]).
      and_return([ "CA", "14" ])
  end

  describe "score lookup by address" do
    it "looks up scorecards by address" do
      get "/scores/lookup", params: address
      expect(response.body).to include("Buffy Summers")
    end

    it "returns scorecards to javascript as json" do
      get "/scores/lookup", params: address.merge({format: :json})
      expect(response.status).to eq(200)
      # expect(response.body).to include("Buffy Summers")
    end
  end
end
