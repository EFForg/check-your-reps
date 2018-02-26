require "rails_helper"

RSpec.describe Score, type: :model do
  describe 'validations' do
    subject(:score) { FactoryBot.build(:score) }

    context 'with an invalid position' do
      before { score.position = 'some nonsense' }

      it { is_expected.not_to be_valid }
    end

    context 'with an valid position' do
      before { score.position = Score::POSITIONS.sample }

      it { is_expected.to be_valid }
    end
  end

  describe '.repair_position' do
    subject(:score) { FactoryBot.build(:score, position: position) }

    context 'if position is valid' do
      let(:position) { Score::POSITIONS.sample }

      it 'does nothing' do
        expect { score.repair_position }.not_to change(score, :position)
      end
    end

    context 'if position is invalid' do
      let(:position) { 'some nonsense' }

      it "sets the position to 'Uncommitted'" do
        expect { score.repair_position }.to change(score, :position)
        expect(score.reload.position).to eq(Score::DEFAULT_POSITION)
      end
    end
  end

  describe ".short_position" do
    let(:score) { FactoryBot.build_stubbed(:score, position: position) }
    subject(:abbreviation) { score.short_position }

    context "when undecided" do
      let(:position) { Score::DEFAULT_POSITION }

      specify { expect(abbreviation).to eq("U") }
    end

    context "when Yes" do
      let(:position) { "Yes" }

      specify { expect(abbreviation).to eq("Y") }
    end

    context "when No" do
      let(:position) { "No" }

      specify { expect(abbreviation).to eq("N") }
    end
  end

  describe "self.lookup" do
    let(:score) do
      FactoryBot.create(:score, congress_member: FactoryBot.create(:senator,
                                                                   state: "CA"))
    end

    it "looks up representatives by address" do
      score
      expect(Score.lookup("CA", "14")).
        to match_array([score])
    end
  end
end
