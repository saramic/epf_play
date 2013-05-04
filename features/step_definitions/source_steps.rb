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

Then /^the source will be created successfully$/ do
  find('.alert').text.should =~ /Source "#{@title}" has been successfully created!/
  find('h1').text.should == @title
end
