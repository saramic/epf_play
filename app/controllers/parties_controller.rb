class PartiesController < ApplicationController
  def index
    scope = Party
    @state = State.find_by_short_name params[:state] if params[:state]
    party = Party.find params[:party] if params[:party]
    scope = scope.representation_in(@state) if @state
    scope = scope.where(id: party) if party
    @listables = scope.all
  end

  def suggest
    @parties = Party.suggest(params[:q])
    render json: @parties
  end

end