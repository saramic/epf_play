class PartiesController < ApplicationController
  def index
    @parties = Party.all
  end

  def suggest
    @parties = Party.where("name ilike '%#{params[:q]}%'")
    render json: @parties
  end

end