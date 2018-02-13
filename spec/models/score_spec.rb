require "rails_helper"

RSpec.describe Score, type: :model do
  describe "self.lookup" do
    let(:my_address) do
      { street: "815 Eddy Street", zipcode: "94109" }
    end

    let(:score) do
      FactoryBot.create(:score, congress_member: FactoryBot.create(:senator,
                                                                   state: "CA"))
    end

    before(:each) do
      allow(SmartyStreets).to receive(:get_congressional_district).
        with(my_address[:street], my_address[:zipcode]).
        and_return([ "CA", "14" ])
    end

    it "looks up representatives by address" do
      score
      expect(Score.lookup(my_address[:street], my_address[:zipcode])).
        to match_array([score])
    end
  end
end
