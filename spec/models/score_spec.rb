require "rails_helper"

RSpec.describe Score, type: :model do
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
