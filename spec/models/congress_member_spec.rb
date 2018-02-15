require "rails_helper"

RSpec.describe CongressMember, type: :model do
  describe "self.lookup" do
    let(:my_congress_members) do
      [ FactoryBot.create(:senator, state: "CA"),
        FactoryBot.create(:representative, state: "CA", district: "14") ]
    end

    let(:not_my_congress_members) do
      [ FactoryBot.create(:senator, state: "NV"),
        FactoryBot.create(:representative, state: "NV", district: "14"),
        FactoryBot.create(:representative, state: "CA", district: "10") ]
    end

    it "looks up representatives by address" do
      my_congress_members && not_my_congress_members
      expect(CongressMember.lookup("CA", "14")).
        to match_array(my_congress_members)
    end

    it "returns an empty association when smarty streets lookup fails" do
      my_congress_members && not_my_congress_members
      expect(CongressMember.lookup("ZZ", "500")).
        to be_a(ActiveRecord::Relation).
        and be_empty
    end
  end
end
