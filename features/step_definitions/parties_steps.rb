Given(/^that the (\d+) senate group voting ticket source is loaded$/) do |arg1|
  FakeWeb.register_uri(:get, 'http://example.com', :body => open(File.join(Rails.root, %w(spec fixtures), 'SenateGroupVotingTicketsDownload-15508.csv')))
  @source = Source.create(url: 'http://example.com')
end

When(/^I process the source$/) do
  ticket_processor = TicketProcessor.new(@source)
  ticket_processor.process.should be_true
end

When(/^I visit the parties page$/) do
  visit parties_path
end

Then(/^I should see the following parties$/) do |parties_table|
  parties_table.raw.each do |parties_line|
    text.should =~ /#{parties_line[0]}/
  end
end