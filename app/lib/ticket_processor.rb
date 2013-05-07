require 'csv'

class TicketProcessor
  def initialize source, csv_file=@source.asset.url
    @source = source
    @csv_file = csv_file
  end

  def process
    csv = CSV.open @csv_file
    #csv = CSV.new '/Users/michael/work/me/epf_play/spec/fixtures/SenateGroupVotingTicketsDownload-15508.csv'
    # TODO write custom headers processor or other to use headers: true and skip first line to access vars as row['OwnerGroupNm']
    csv.drop(2).each do |row|
      Party.create(name: row[2])
    end
  end
end