require "rails_helper"

describe "Lookup of scores by address", type: :request do
  let(:body) { Nokogiri::HTML(response.body) }
  let!(:t_rex) { FactoryBot.create(:senator, name: "T-Rex", state: "CA") }
  let!(:bronto) { FactoryBot.create(:senator, name: "Brontosaurus", state: "NV") }
  let!(:raptor) { FactoryBot.create(:senator, name: "V.Raptor", state: "CA") }

  before do
    t_rex.score.update(position: 'Yes')
    bronto.score.update(position: 'Yes')
    get "/scores"
  end

  it "shows all scores with non-nil positions" do
    cell_content = body.search('td').map(&:text)

    expect(cell_content).to include("Sen. #{t_rex.name}")
    expect(cell_content).to include("Sen. #{bronto.name}")
    expect(cell_content).not_to include("Sen. #{raptor.name}")
  end

  it 'contains tweet input for each congress member with a valid position alphabetically' do
    tweet_links = body.search('a').select do |a|
      a.text == 'Tweet' &&
      a[:href].match(/twitter.com\/intent\/tweet/)
    end.map{|l| l[:href]}

    expect(tweet_links.count).to eq([t_rex, bronto].count)
    expect(tweet_links.find { |href| href.match(/T-Rex/) }).to be_present
    expect(tweet_links.find { |href| href.match(/Brontosaurus/) }).to be_present
  end
end
