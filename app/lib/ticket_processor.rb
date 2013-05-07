require 'csv'
require 'open-uri'

class TicketProcessor
  def initialize source
    @source = source
  end

  def process
    file = open(@source.asset.path)
    file.readline # drop first line
    party_count = 0
    CSV.parse(file, headers: true).each do |row|
      party = Party.create(name: row["OwnerGroupNm"])
      party_count += 1 if party.errors.count == 0
    end
    party_count
  end
end