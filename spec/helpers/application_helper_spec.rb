require "rails_helper"

describe ShareLinkHelper do
  describe '#js_tracking_image' do
    let(:piwik_id) { 1234 }
    subject(:js_tracking_image) { helper.js_tracking_image(piwik_id) }

    it 'takes a piwik id' do
      expect(js_tracking_image).to include(piwik_id.to_s)
    end

    it 'is an image tag' do
      expect(js_tracking_image).to match(/<img .* src=/)
    end
  end
end

