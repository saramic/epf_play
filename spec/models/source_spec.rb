require 'spec_helper'

describe Source do
  let(:url) { 'http://www.aph.gov.au/Senators_and_Members/Senators/Senators_photos' }
  before do
    fixture_file = open(File.join(Rails.root, %w(spec fixtures Senator_photos.html)))
    FakeWeb.register_uri(:get, url, :body => fixture_file)
  end

  describe :store_asset do
    let(:source) { Source.create(url: url) }
    subject { source }

    context :valid do
      it { should be_valid }
    end

    context "invalid without url" do
      before { source.url = nil }
      it { should_not be_valid }
    end

    context "save url to asset" do
      it { source.asset.to_s.should =~ /\/uploads\/source\/asset\/.*\/Senators_photos/}
      its(:hash_identifier) { should == '69f32717eec62e478efd4d643a486a9e' }
    end

    context "save duplicate asset" do
      before { source } # get the original source instantiated
      let(:source_duplicate) { Source.create(url: url) }
      subject { source_duplicate }
      it { should_not be_valid }
      it { source_duplicate.errors.full_messages.should eql(["Hash identifier has already been taken"])}
    end
  end
end
