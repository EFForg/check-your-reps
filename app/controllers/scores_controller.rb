class ScoresController < ApplicationController
  def lookup
    @scores = Score.lookup(params[:street], params[:zipcode])
    respond_to do |format|
      format.html { render "home/index" }
      format.json { render json: @scores }
    end
  end
end
