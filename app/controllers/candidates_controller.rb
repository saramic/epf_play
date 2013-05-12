class CandidatesController < ApplicationController
  def index
    scope = Candidate
    party = Party.find(params[:party]) if params[:party]
    @state = State.find_by_short_name params[:state] if params[:state]
    scope = scope.where(party_id: party) if party
    scope = scope.where(state_id: @state) if @state
    @listables = scope.all
  end

  def suggest
    @candidates = Candidate.suggest(params[:q])
    render json: @candidates
  end

end