class HomeController < ApplicationController
  def index
    @listables = State.all
    scope = Party
    @state = State.find_by_short_name params[:state] if params[:state]
    party = Party.find params[:party] if params[:party]
    scope = scope.representation_in(@state) if @state
    scope = scope.where(id: party) if party
    @parties = scope.all
    @parties = @parties.first.candidates if party && @parties.count == 1

  end
end
