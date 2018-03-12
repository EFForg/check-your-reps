require 'rails_helper'

RSpec.describe AdminMailer, type: :mailer do
  describe "#new_congress_members" do
    let!(:reps) { FactoryBot.create_list(:congress_member, 2) }
    let(:mail) { AdminMailer.new_congress_members(reps) }

    it "sends email to all admins" do
      expect(mail.to).to match_array(AdminUser.pluck(:email))
    end

    it "mentions the needy reps by name" do
      expect(mail.body.encoded).to include(reps.first.name)
    end

    it "links to the admin page" do
      expect(mail.body.encoded).to include(admin_congress_members_url)
    end
  end
end
