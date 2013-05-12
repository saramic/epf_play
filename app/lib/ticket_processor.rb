require 'csv'
require 'open-uri'

class TicketProcessor
  def initialize source
    @source = source
  end

  def process
    file = open(@source.asset.url) rescue open(@source.asset.path) # TODO hack .url prod .path cucumber
    file.readline # drop first line
    counts = {parties: {}, candidates: {}}
    CSV.parse(file, headers: true).each do |row|
      party = Party.find_or_create_by_name(name: row["PartyNm"] || 'no party')
      candidate = Candidate.create(
          given_name: row["GivenNm"],
          surname: row['Surname'],
          aec_candidate_id: row['CandidateID'],
          party: party,
          state: State.find_by_short_name(row['State'])
      )
      puts candidate.errors.full_messages
      counts[:parties][party.name] = true
      counts[:candidates][candidate.aec_candidate_id] = true
      #party_count += 1 if party.errors.count == 0
    end
    counts[:parties] = counts[:parties].keys.count
    counts[:candidates] = counts[:candidates].keys.count
    counts
  end
end