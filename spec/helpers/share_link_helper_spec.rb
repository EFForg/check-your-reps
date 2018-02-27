require "rails_helper"

describe ShareLinkHelper do
  describe '#share_link' do
    it 'gets the right url' do
      expect(helper).to receive(:facebook_share_url).and_return("facebook.com/share")
      helper.share_link :facebook
    end
  end

  describe '#twitter_share_url' do
    it 'accepts a custom message' do
      expect(twitter_share_url "Rawr!").to include("Rawr%21")
    end
  end

  describe '#tweet_score_link' do
    let(:score) { FactoryBot.build_stubbed(:score) }

    subject(:tweet_score_link) { helper.tweet_score_link(score) }

    it 'is a link' do
      expect(tweet_score_link).to match(/<a .* href=/)
    end

    it 'has the right message' do
      expect(helper).to receive(:tweet_score_message).with(score)
      tweet_score_link
    end
  end

  describe '#tweet_score_message' do
    let(:position) { Score::DEFAULT_POSITION }
    let(:handle) { '@RepRaptor' }
    let(:score) { FactoryBot.create(:score, position: position) }
    let(:website) { 'https://checkyourreps.org' }

    subject(:tweet_score_message) { helper.tweet_score_message(score) }

    before do
      allow(score.congress_member).to receive(:twitter_handle).and_return(handle)
    end

    it 'defaults to undecided' do
      expect(tweet_score_message).to match(
        /Why hasn't #{handle} taken a stand/
      )
    end

    it 'links back to us' do
      expect(tweet_score_message).to include(website)
    end

    context 'when position is yes' do
      let(:position) { 'Yes' }

      it 'lauds the congress member' do
        expect(tweet_score_message).to match(
          /I'm glad to see #{handle} has committed/
        )
      end

      it 'links back to us' do
        expect(tweet_score_message).to include(website)
      end
    end

    context 'when position is no' do
      let(:position) { 'No' }

      it 'castigates the congress member' do
        expect(tweet_score_message).to match(
          /Even though 83% of Americans support #NetNeutrality, #{handle} doesn't/
        )
      end

      it 'links back to us' do
        expect(tweet_score_message).to include(website)
      end
    end
  end
end
