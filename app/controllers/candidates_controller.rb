class CandidatesController < ApplicationController
  def index
    @candidates = Candidate.all
  end

  def suggest
    @candidates = Candidate.suggest(params[:q])
    render json: @candidates
  end

end