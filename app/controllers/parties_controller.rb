class PartiesController < ApplicationController
  def index
    scope = Party
    @state = State.find_by_short_name params[:state] if params[:state]
    party = Party.find params[:party] if params[:party]
    scope = scope.representation_in(@state) if @state
    scope = scope.where(id: party) if party
    @parties = scope.all
    if party && @parties.count == 1
      candidate_scope = @parties.first.candidates
      candidate_scope = candidate_scope.where(state_id: @state) if @state
      @parties = candidate_scope.all
    end
  end

  def suggest
    @parties = Party.suggest(params[:q])
    render json: @parties
  end

end