require "rails_helper"

describe "Lookup of scores by address", type: :request do
  let(:score) do
    FactoryBot.create(:score, congress_member: FactoryBot.create(:senator,
                                                                 state: "CA"))
  end

  let(:address) do
    { street: "815 Eddy Street", zipcode: "94109" }
  end

  describe "successful score lookup" do
    before(:each) do
      allow(SmartyStreets).to receive(:get_district).
        with(address[:street], address[:zipcode]).
        and_return([ "CA", "14" ])
    end

    before(:each) { score }

    before(:each) do
      allow(SmartyStreets).to receive(:get_district).
        with(address[:street], address[:zipcode]).
        and_return([ "CA", "14" ])
    end

    it "shows the user's state and district" do
      get "/scores/lookup", params: address
      expect(response.body).to include("California District 14")
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

  describe "error handling" do
    it "shows an error when the address isn't recognized" do
      allow(SmartyStreets).to receive(:post).
        and_return(false)

      get "/scores/lookup", params: { street: "foo", zipcode: "bar" }
      expect(response.body).to include("didn't recognize the address")
    end

    it "shows an error when the address isn't recognized" do
      allow(SmartyStreets).to receive(:get_district).
        with(address[:street], address[:zipcode]).
        and_return([ "CA", "14" ])

      get "/scores/lookup", params: address
      expect(response.body).to include("couldn't find any information for")
    end
  end
end
