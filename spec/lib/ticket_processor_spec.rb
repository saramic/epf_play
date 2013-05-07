require "spec_helper"

describe TicketProcessor do
  let(:fake_source_asset) {"""OwnerGroupNm
Party 1
Party 1
Party 2
  """}
  #let(:source) { FactoryGirl.create(:source) }
  let(:ticket_processor) { TicketProcessor.new(Source.new, StringIO.new(fake_source_asset))}

  it "should create parties form the source" do
    ticket_processor.process
    Party.count.should == 2
    Party.find_by_name('Party 1').should be_true
    Party.find_by_name('Party 2').should be_true
    Party.find_by_name('Party 3').should be_false
  end
end
