# frozen_string_literal: true
require "rest_client"

module SmartyStreets
  class AddressNotFound < StandardError; end

  def self.get_district(street, zipcode)
    url = "https://api.smartystreets.com/street-address"
    res = post(url, base_params.merge(street: street, zipcode: zipcode))
    if res && res.first
      district = res.first.dig("metadata", "congressional_district")
      district = "0" if district == "AL"
      [res.first["components"]["state_abbreviation"], district]
    else
      raise AddressNotFound
    end
  end

  private
  def self.post(url, params)
    begin
      res = JSON.parse RestClient.get("#{url}?#{params.to_query}")
      return res
    rescue => e
      Rails.logger.error "#{ e } (#{ e.class })!"
      return false
    end
  end

  def self.base_params
    {
      "auth-id" => Rails.application.secrets.smarty_streets_id,
      "auth-token" => Rails.application.secrets.smarty_streets_token
    }
  end
end
