# frozen_string_literal: true
class ScoresController < ApplicationController
  def index
    @scores = Score.with_position
      .joins(:congress_member)
      .order("congress_members.name ASC")
  end

  def lookup
    begin
      @location = params.permit(:street, :zipcode).merge(
        SmartyStreets.get_district(params[:street], params[:zipcode])
      )
      @scores = Score.with_position.lookup(@location[:state], @location[:district])
    rescue SmartyStreets::AddressNotFound => e
      @error = :address_not_found
    end

    respond_to do |format|
      format.html { render "home/index" }
      format.json { render json: @scores }
    end
  end
end
