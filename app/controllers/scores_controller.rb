class ScoresController < ApplicationController
  def lookup
    render json: CongressMember.lookup(params[:street], params[:zipcode])
  end
end
