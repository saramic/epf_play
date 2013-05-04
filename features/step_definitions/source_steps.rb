Given /^that the URL for the source exists$/ do |url_table|
  url_table.raw.each do |url_string, url_file|
    @fake_file_name = File.join(Rails.root, %w(spec fixtures), url_file)
    FakeWeb.register_uri(:get, url_string, :body => open(@fake_file_name))
  end
end

When /^I go to create a new source$/ do
  visit sources_path
  click_link 'Add a Source'
end

When /^I create the source$/ do |source_table|
  source_table.raw.each do |field, value|
    @title = value if field == 'title'
    fill_in "source_#{field}", with: value
  end

  click_button 'Add Source'
end

Then /^the source will be ([^ ]+) successfully$/ do |action|
  find('.alert').text.should =~ /Source "#{@title}" has been successfully #{action}!/
  find('h1').text.should == @title
  @source = Source.last
end

Then /^the url will be downloaded and stored$/ do
  @source.asset.should eql(File.read(@fake_file_name))
end

When(/^I go back to list sources$/) do
  click_link 'cancel'
end

Then(/^I should see the source$/) do
  within("#source_#{@source.id}") do
    text.should =~ /#{@source}/
  end
end

When(/^I edit the source$/) do
  within("#source_#{@source.id}") do
    click_link 'Edit'
  end
end

When(/^I update the source$/) do |source_table|
  source_table.raw.each do |field, value|
    @title = value if field == 'title'
    fill_in "source_#{field}", with: value
  end

  click_button 'Update Source'
end

Then(/^source update will fail with "(.*?)"$/) do |error_message|
  find('.alert').text.should =~ /#{error_message}/
end

Then(/^the update will not take place$/) do |source_table|
  source_table.raw.each do |field, value|
    @title = value if field == 'title'
    find("#source_#{field}").value.should_not =~ /#{value}/
  end
end

