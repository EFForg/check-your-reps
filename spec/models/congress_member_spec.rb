require "rails_helper"

RSpec.describe CongressMember, type: :model do
  describe "ensure_score" do
    let(:rep) { FactoryBot.build(:congress_member) }

    it "creates a score for a new rep" do
      expect { rep.save }.to change(Score, :count).by(1)
      expect(rep.score).to be_present
      expect(rep.position).to be_nil
    end

    context "with a score" do
      before { FactoryBot.build(:score, position: 'Yes', congress_member: rep) }

      it "respects the score" do
        expect { rep.save }.to change(Score, :count).by(1)
        expect(rep.position).to eq("Yes")
      end
    end
  end

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

  describe 'twitter_handle' do
    let(:bob) { FactoryBot.create(:congress_member, twitter_id: id) }
    let(:useful_handle) { '@bob' }

    context 'when twitter_id can be parsed' do
      let(:id) { useful_handle }

      it 'returns a useful handle' do
        expect(bob.twitter_handle).to eq(useful_handle)
      end
    end

    context 'when twitter_id is missing an @' do
      let(:id) { 'bob' }

      it 'returns a useful handle' do
        expect(bob.twitter_handle).to eq(useful_handle)
      end
    end
  end
end
