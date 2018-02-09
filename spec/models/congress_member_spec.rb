require "rails_helper"

RSpec.describe CongressMember, type: :model do
  describe "self.lookup" do
    let(:my_address) do
      { street: "815 Eddy Street", zipcode: "94109" }
    end

    let(:my_congress_members) do
      [ FactoryBot.create(:senator, state: "CA"),
        FactoryBot.create(:representative, state: "CA", district: "14") ]
    end

    let(:not_my_congress_members) do
      [ FactoryBot.create(:senator, state: "NV"),
        FactoryBot.create(:representative, state: "NV", district: "14"),
        FactoryBot.create(:representative, state: "CA", district: "10") ]
    end

    before(:each) do
      allow(SmartyStreets).to receive(:get_congressional_district).
        with(my_address[:street], my_address[:zipcode]).
        and_return([ "CA", "14" ])
    end

    it "looks up representatives by address" do
      my_congress_members && not_my_congress_members
      expect(CongressMember.lookup(my_address[:street], my_address[:zipcode])).
        to match_array(my_congress_members)
    end
  end
end
