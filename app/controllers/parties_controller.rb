class PartiesController < ApplicationController
  load_and_authorize_resource

  def index
    scope = Party
    @state = State.find_by_short_name params[:state] if params[:state]
    @party = Party.find params[:party] if params[:party]
    scope = scope.representation_in(@state) if @state
    scope = scope.where(id: @party) if @party
    @listables = scope.all
  end

  def edit
    @party = Party.find(params[:id])
  end

  def update
    @party = Party.find(params[:id])
    if @party.update_attributes(params[:party])
      flash[:notice] = "Party \"#{@party}\" has been successfully updated!"
      redirect_to edit_party_path(@party)
    else
      flash[:error] = "Party not updated. Please review the messages below."
      render :edit
    end
  end

  def suggest
    @parties = Party.suggest(params[:q])
    render json: @parties
  end

end