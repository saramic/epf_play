require 'spec_helper'

describe Source do
  describe :store_asset do
    let(:source) { FactoryGirl.create :source }
    subject { source }

    context :valid do
      it { should be_valid }
    end

    context "invalid without title" do
      before { source.url = '  ' }
      before { source.title = nil }
      it { should_not be_valid }
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
      it { lambda{ FactoryGirl.create(:source) }.should raise_error(ActiveRecord::RecordInvalid, 'Validation failed: Hash identifier has already been taken') }
    end
  end

  describe 'generate title from url' do
    let(:google_com) { 'http://www.not-google.com/' }
    let(:aec_gov_au) { 'http://www.not-aec.gov.au/' }
    let(:aec_parties_and_reps) { 'http://www.not-aec.gov.au/Parties_and_Representatives/' }
    let(:aec_registered_parties_2010) { 'http://www.not-aec.gov.au/Parties_and_Representatives/Party_Registration/Registered_parties/2010.htm' }
    let(:aec_camel_case) { 'http://www.aec.gov.au/Elections/Federal_Elections/2010/files/DivisionHistoricFirstPrefsExtract.csv' }
    before do
      FakeWeb.register_uri(:get, google_com, :body => '')
      FakeWeb.register_uri(:get, aec_gov_au, :body => '')
      FakeWeb.register_uri(:get, aec_parties_and_reps, :body => '')
      FakeWeb.register_uri(:get, aec_registered_parties_2010, :body => '')
      FakeWeb.register_uri(:get, aec_camel_case, :body => '')
    end
    let(:source) { FactoryGirl.create :source, url: url, title: '  ' }
    subject { source }
    context "host .com" do
      let(:url) { google_com }
      its(:title) { should eql 'Not google'}
    end
    context "host .gov.au" do
      let(:url) { aec_gov_au }
      its(:title) { should eql 'Not aec gov'}
    end
    context "path" do
      let(:url) { aec_parties_and_reps }
      its(:title) { should eql 'Parties and representatives'}
    end
    context "file" do
      let(:url) { aec_registered_parties_2010 }
      # TODO room for improvement
      #its(:title) { should eql 'Registered parties 2010'}
      its(:title) { should eql 'Parties and representatives party registration registered parties 2010 htm'}
    end
    context "CamelCase" do
      let(:url) { aec_camel_case }
      its(:title) { should eql 'Elections federal elections 2010 files division historic first prefs extract csv'}
    end
  end
end
