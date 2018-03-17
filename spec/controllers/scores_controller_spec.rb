require "rails_helper"

RSpec.describe ScoresController do
  describe "GET index" do
    it "shows all scores with non-nil positions" do
      expect(Score).to receive(:with_position)
      get :index 
    end
  end

  describe "GET lookup" do
    describe "with a valid address" do
      before { allow(SmartyStreets).to receive(:get_district) }

      it "shows all scores with non-nil positions" do
        expect(Score).to receive(:with_position).and_call_original
        get :lookup
      end
    end
  end
end
