require "rails_helper"

describe "Lookup of scores by address", type: :request do
  let(:body) { Nokogiri::HTML(response.body) }
  let!(:scores) do
    [FactoryBot.create(:senator, name: "Brontosaurus", state: "NV").score,
     FactoryBot.create(:senator, name: "T-Rex", state: "CA").score]
  end

  before do
    Score.update_all(position: 'Yes')
    get "/scores"
  end

  it "shows all scores" do
    cell_content = body.search('td').map(&:text)

    expect(cell_content).to include("Sen. T-Rex")
    expect(cell_content).to include("Sen. Brontosaurus")
  end

  it 'contains tweet input for each congress member' do
    tweet_links = body.search('a').select do |a|
      a.text == 'Tweet' &&
      a[:href].match(/twitter.com\/intent\/tweet/)
    end.map{|l| l[:href]}

    expect(tweet_links.count).to eq(CongressMember.count)
    expect(tweet_links.find { |href| href.match(/T-Rex/) }).to be_present
    expect(tweet_links.find { |href| href.match(/Brontosaurus/) }).to be_present
  end
end
