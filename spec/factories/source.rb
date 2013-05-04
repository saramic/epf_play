# -*- encoding : utf-8 -*-
require 'fakeweb'

FactoryGirl.define do
  fixture_file = open(File.join(Rails.root, %w(spec fixtures Senator_photos.html)))
  url_string = 'http://www.aph.gov.au/Senators_and_Members/Senators/Senators_photos'
  FakeWeb.register_uri(:get, url_string, :body => fixture_file)

  factory :source, :class => Source do
    title "the title"
    url url_string
  end
end
