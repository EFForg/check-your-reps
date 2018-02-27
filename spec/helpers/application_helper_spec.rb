require "rails_helper"

describe ShareLinkHelper do
  describe '#js_tracking_image' do
    let(:piwik_id) { 1234 }
    subject(:tracking_image) { helper.tracking_image(piwik_id) }

    it 'takes a piwik id' do
      expect(tracking_image).to include(piwik_id.to_s)
    end

    it 'is an image tag' do
      expect(tracking_image).to match(/<img .* src=/)
    end

    it 'defaults to not tracking referrer' do
      expect(tracking_image).not_to include('urlref')
    end

    describe 'with js' do
      subject(:js_tracking_image) { helper.tracking_image(piwik_id, js: true) }

      it 'includes a referrer keyword for templating' do
        expect(js_tracking_image).to include("urlref=REFERRER")
      end
    end
  end
end

