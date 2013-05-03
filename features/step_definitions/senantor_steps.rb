require "rake"

Given(/^I have a source$/) do
  SenatorImporter::SOURCE.should eql("http://www.aph.gov.au/Senators_and_Members/Senators/Senators_photos")
end

When(/^I run the senator importer$/) do
  # TODO run as a rake task? - fake out not to hit the web in tests?
  #@rake = Rake::Application.new
  #Rake.application = @rake
  #Rake.application.rake_require "tasks/senator_importer"
  #Rake::Task.define_task(:environment)
  #@rake['import:senators'].invoke

  SenatorImporter.new(File.join(Rails.root, %w(spec fixtures Senator_photos.html))).import
end

When(/^I visit senator list$/) do
  visit senators_path
end

Then(/^I should see the senators$/) do
  # TODO could count 75 senators and got by #senator_#{id} but not sure of the id :(
  first('dd').text.should eql 'Senator the Hon Eric Abetz'
end

