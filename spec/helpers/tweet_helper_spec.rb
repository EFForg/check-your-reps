require "rails_helper"

describe TweetHelper do
  describe '#tweet_link' do
    let(:score) { FactoryBot.build_stubbed(:score) }

    subject(:tweet_link) { helper.tweet_link(score) }

    it 'is a link' do
      expect(tweet_link).to match(/<a .* href=/)
    end

    it 'has the right message' do
      expect(helper).to receive(:tweet_message).with(score)
      tweet_link
    end
  end

  describe '#tweet_message' do
    let(:position) { Score::DEFAULT_POSITION }
    let(:handle) { '@RepRaptor' }
    let(:score) { FactoryBot.create(:score, position: position) }
    let(:website) { 'https://checkyourreps.org' }

    subject(:tweet_message) { helper.tweet_message(score) }

    before do
      allow(score.congress_member).to receive(:twitter_handle).and_return(handle)
    end

    it 'defaults to undecided' do
      expect(tweet_message).to match(
        /Why hasn't #{handle} taken a stand/
      )
    end

    it 'links back to us' do
      expect(tweet_message).to include(website)
    end

    context 'when position is yes' do
      let(:position) { 'Yes' }

      it 'lauds the congress member' do
        expect(tweet_message).to match(
          /I'm glad to see #{handle} has committed/
        )
      end

      it 'links back to us' do
        expect(tweet_message).to include(website)
      end
    end

    context 'when position is no' do
      let(:position) { 'No' }

      it 'castigates the congress member' do
        expect(tweet_message).to match(
          /Even though 83% of Americans support #NetNeutrality, #{handle} doesn't/
        )
      end

      it 'links back to us' do
        expect(tweet_message).to include(website)
      end
    end
  end
end
