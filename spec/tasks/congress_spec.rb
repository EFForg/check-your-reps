require 'rails_helper'
require "rake"

RSpec.describe 'congress tasks' do
  before do
    Rake.application.rake_require("tasks/congress")
    Rake::Task.define_task(:environment)
  end

  after { Rake.application[task].reenable }

  describe "congress:check_for_updates" do
    let(:task) { "congress:check_for_updates" }
    let(:update_result) { {} }
    let(:run_task) do
      Rake.application.invoke_task task
    end

    before do
      allow(Rake::Task["congress:update"]).to receive(:invoke) { update_result }
      allow(AdminMailer).to receive(:new_congress_members)
        .and_return(double(deliver: false))
    end

    it 'updates congress' do
      expect(Rake::Task["congress:update"]).to receive(:invoke)
      run_task
    end

    it 'sends no email' do
      expect(AdminMailer).not_to receive(:new_congress_members)
      run_task
    end

    context 'when a new congress member is created' do
      let(:update_result) { FactoryBot.create(:congress_member) }

      it 'reminds admins to update the new positions' do
        expect(AdminMailer).to receive(:new_congress_members)
        run_task
      end
    end
  end
end
