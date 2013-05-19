class Ballot < ActiveRecord::Base
  attr_accessible :state, :election
  belongs_to :state
  belongs_to :election
  has_many :tickets

  def reduce steps=nil
    step = 1
    next_step = step + 1
    tickets.each do |ticket|
      # group ticket preference
      if step == 1 and ticket.ballot_positions.first.position == 0 and !ticket.ballot_positions.first.ordinal_preferences.last.votes.nil?
        # TODO should this be in a transaction?
        group_votes = ticket.ballot_positions.first.ordinal_preferences.last.votes
        votes = ticket.ballot_positions.second.ordinal_preferences.last.votes
        # TODO this vote move should be dictated by the group preferences
        ticket.ballot_positions.second.ordinal_preferences << OrdinalPreference.create(ordinal: next_step, votes: votes + group_votes)
        ticket.ballot_positions.first.ordinal_preferences << OrdinalPreference.create(ordinal: next_step, votes: nil)
      end
    end
  end
end