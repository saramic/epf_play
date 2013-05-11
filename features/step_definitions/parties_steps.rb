Given(/^that the (\d+) senate group voting ticket source is loaded$/) do |year, file_contents|
  FakeWeb.register_uri(:get, 'http://example.com', :body => file_contents)
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

When /^I visit the candidates page$/ do
  visit candidates_path
end

Then /^I should see the following candidates$/ do |candidates_table|
  candidates_table.raw.each do |candidate_line|
    text.should =~ /#{candidate_line[0]}/
  end
end

When /^I visit the homepage$/ do
  visit root_path
end

When /^navigate by state "(.*?)"$/ do |state_name|
  click_on state_name
end

Then /^I should (not )?see the party "(.*?)"$/ do |truth, party_name|
  if truth == 'not '
    text.should_not =~ /#{party_name}/
  else
    text.should =~ /#{party_name}/
  end
end

When /^I navigate by party "(.*?)"$/ do |party_name|
  click_on party_name
end

Then /^I should (not )?see the candidate "(.*?)"$/ do |truth, candidate_name|
  if truth == 'not '
    text.should_not =~ /#{candidate_name}/
  else
    text.should =~ /#{candidate_name}/
  end
end
