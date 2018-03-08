# frozen_string_literal: true
class AdminUser < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :invitable,
         :recoverable, :rememberable, :trackable, :validatable
end
