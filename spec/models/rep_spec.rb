require "rails_helper"

RSpec.describe Rep, type: :model do
  describe "self.lookup" do
    let(:my_address) do
      { street: "815 Eddy Street", zipcode: "94109" }
    end

    let(:my_reps) do
      [ FactoryBot.create(:senator, state: "CA"),
        FactoryBot.create(:house_rep, state: "CA", district: "14") ]
    end

    let(:not_my_reps) do
      [ FactoryBot.create(:senator, state: "NV"),
        FactoryBot.create(:house_rep, state: "NV", district: "14"),
        FactoryBot.create(:house_rep, state: "CA", district: "10") ]
    end

    before(:each) do
      allow(SmartyStreets).to receive(:get_congressional_district).
        with(my_address[:street], my_address[:zipcode]).
        and_return([ "CA", "14" ])
    end

    it "looks up representatives by address" do
      my_reps && not_my_reps
      expect(Rep.lookup(my_address[:street], my_address[:zipcode])).to match_array(my_reps)
    end
  end
end
