require 'rails_helper'
require "rake"

RSpec.describe 'congress tasks' do
  before do
    Rake.application.rake_require("tasks/congress")
    Rake::Task.define_task(:environment)
  end

  let(:args) { nil }
  let(:run_task) { Rake.application.invoke_task("#{task}#{args}") }

  after { Rake.application[task].reenable }

  describe "congress:update" do
    let(:task) { "congress:update" }

    before do
      allow(RestClient).to receive(:get).and_return(
        File.open('./spec/fixtures/social_media.yaml').read,
        File.open('./spec/fixtures/current_reps.yaml').read,
        File.open('./spec/fixtures/historical_reps.yaml').read
      )
      allow(AdminMailer).to receive(:new_congress_members)
        .and_return(double(deliver: true))
    end

    it 'sends no email' do
      expect(AdminMailer).not_to receive(:new_congress_members)
      run_task
    end

    context "when notifications are turned on" do
      let(:args) { [notify: true] }

      it 'reminds admins to update the new positions' do
        expect(AdminMailer).to receive(:new_congress_members)
        run_task
      end
    end
  end
end
