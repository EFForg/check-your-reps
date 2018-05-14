require "rails_helper"

describe "Lookup of scores by address", type: :request do
  let!(:rep) { FactoryBot.create(:representative, state: "CA", district: "14") }
  let!(:sen) { FactoryBot.create(:senator, state: "CA") }
  let!(:empty_rep) { FactoryBot.create(:representative, state: "CA", district: "14") }
  let(:address) do
    { street: "815 Eddy Street", zipcode: "94109" }
  end

  before do
    rep.score.update(position: "Yes")
    sen.score.update(position: "Yes")
  end

  describe "successful score lookup" do
    before(:each) do
      allow(SmartyStreets).to receive(:get_district).
        with(address[:street], address[:zipcode]).
        and_return({ state: "CA", district: "14" })
    end

    it "only includes House members" do
      get "/scores/lookup", params: address
      expect(response.body).not_to include(sen.name)
      expect(response.body).to include(rep.name)
    end

    it "shows the user's state and district" do
      get "/scores/lookup", params: address
      expect(response.body).to include("California District 14")
    end

    it "looks up scorecards by address" do
      get "/scores/lookup", params: address
      expect(response.body).to include("Buffy Summers")
    end

    it "does not include empty scorecards" do
      get "/scores/lookup", params: address
      expect(response.body).not_to include(empty_rep.name)
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
        and_return({ state: "NV", district: "09" })

      get "/scores/lookup", params: address
      expect(response.body).to include("couldn't find any information for")
    end
  end
end
