Given(/^I have a source$/) do
  SenatorImporter::SOURCE.should eql("http://www.aph.gov.au/Senators_and_Members/Senators/Senators_photos")
end

When(/^I run the senator importer$/) do
  # TODO run as a rake task? - fake out not to hit the web in tests?
  SenatorImporter.new(File.join(Rails.root, %w(spec fixtures Senator_photos.html))).import
end

When(/^I visit senator list$/) do
  visit senators_path
end

Then(/^I should see the senators$/) do
  pending # express the regexp above with the code you wish you had
end
