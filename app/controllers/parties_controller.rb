class PartiesController < ApplicationController
  def index
    @parties = Party.all
  end

  def suggest
    @parties = Party.suggest(params[:q])
    render json: @parties
  end

end