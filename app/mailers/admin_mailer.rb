# frozen_string_literal: true

class AdminMailer < ActionMailer::Base
  def new_congress_members(members)
    @names = members.map(&:name).to_sentence

    mail to: AdminUser.pluck(:email),
      subject: "New congress members need scores in Check Your Reps"
  end
end
