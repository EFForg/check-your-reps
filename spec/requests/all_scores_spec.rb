require "rails_helper"

describe "Lookup of scores by address", type: :request do
  let(:scores) do
    [
      FactoryBot.create(:score, congress_member: FactoryBot.create(:senator,
                                                                   name: "T-Rex",
                                                                   state: "CA")),
      FactoryBot.create(:score, congress_member: FactoryBot.create(:senator,
                                                                   name: "Brontosaurus",
                                                                   state: "NV"))
    ]
  end

  before(:each) { scores }

  it "shows all scores" do
    get "/scores"
    expect(response.body).to include("T-Rex")
    expect(response.body).to include("Brontosaurus")
  end
end
