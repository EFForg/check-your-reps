require "rails_helper"

describe "Lookup of scores by address", type: :request do
  let(:body) { Nokogiri::HTML(response.body) }
  let!(:scores) do
    [
      FactoryBot.create(:score, congress_member: FactoryBot.create(:senator,
                                                                   name: "T-Rex",
                                                                   state: "CA")),
      FactoryBot.create(:score, congress_member: FactoryBot.create(:senator,
                                                                   name: "Brontosaurus",
                                                                   state: "NV"))
    ]
  end

  before { get "/scores" }

  it "shows all scores" do
    cell_content = body.search('td').map(&:text)

    expect(cell_content).to include("Sen. T-Rex")
    expect(cell_content).to include("Sen. Brontosaurus")
  end

  it 'contains tweet input for each congress member' do
    tweet_links = body.search('a').select do |a|
      a.text == 'Tweet' &&
      a[:href].match(/twitter.com\/intent\/tweet/)
    end

    expect(tweet_links.count).to eq(CongressMember.count)
    expect(tweet_links.first[:href]).to match(/T-Rex/)
    expect(tweet_links.last[:href]).to match(/Brontosaurus/)
  end
end
