require 'csv'
require 'open-uri'

class AecResultsProcessor
  def initialize source
    @source = source
  end

  def process
    file = open(@source.asset.url) rescue open(@source.asset.path) # TODO hack .url prod .path cucumber
    first_line = file.readline # drop first line
    election_name = first_line.scan(/^\d+ Federal Election/).first
    CSV.parse(file, headers: true).each do |row|
      election = Election.find_or_create_by_name(election_name)
      ballot = Ballot.find_or_create_by_state_id_and_election_id(State.find_by_short_name(row['StateAb']).id, election.id)
      ticket = Ticket.find_or_create_by_ballot_id_and_position(ballot.id, row['Ticket']) do |ticket|
        ticket.party = Party.find_or_create_by_name(row['PartyName'])
      end
      ballot_position = BallotPosition.find_or_create_by_ticket_id_and_position(ticket.id, row['BallotPosition']) do |ballot_position|
        #ballot_position.candidate_id = row['CandidateID'] # TODO make aec_candidate_id the default id ?
        ballot_position.candidate = Candidate.find_by_aec_candidate_id row['CandidateID']
      end
      # TODO confirm that candidate and party exist?
      OrdinalPreference.create(ordinal: 1, votes: row['TotalVotes'], ballot_position: ballot_position)
    end
  end
end