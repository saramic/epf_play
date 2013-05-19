class BallotsController < ApplicationController
  def index
    # TODO stuck on 1 election and 1 state
    election = Election.first
    ballot = Ballot.where(election_id: election).where(state_id: State.find_by_short_name('VIC')).first
    @tickets = ballot.tickets
  end
end