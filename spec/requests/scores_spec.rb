require "rails_helper"

describe "Public access to scores", type: :request do
  let(:score) do
    FactoryBot.create(:score, congress_member: FactoryBot.create(:senator,
                                                                 state: "CA"))
  end

  let(:address) do
    { street: "815 Eddy Street", zipcode: "94109" }
  end

  before(:each) { score }

  describe "successful score lookup by address" do
    before(:each) do
      allow(SmartyStreets).to receive(:get_congressional_district).
        with(address[:street], address[:zipcode]).
        and_return([ "CA", "14" ])
    end

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

  it "shows an error when no scores are found for the given address" do
    allow(SmartyStreets).to receive(:get_congressional_district).
      with(address[:street], address[:zipcode]).
      and_return(false)
    get "/scores/lookup", params: address
    expect(response.body).to include("Sorry")
  end
end
