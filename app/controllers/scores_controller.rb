class ScoresController < ApplicationController
  def index
    @scores = Score.all
  end

  def lookup
    begin
      @state, @district = SmartyStreets.get_district(params[:street], params[:zipcode])
      @scores = Score.lookup(@state, @district)
    rescue SmartyStreets::AddressNotFound => e
      @error = :address_not_found
    end

    respond_to do |format|
      format.html { render "home/index" }
      format.json { render json: @scores }
    end
  end
end
