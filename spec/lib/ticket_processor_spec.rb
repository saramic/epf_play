require "spec_helper"

describe TicketProcessor do
  let(:fake_source_asset) {"""
State,OwnerGroupNm
NSW,Party 1
VIC,Party 1
ACT,Party 2
"""}
  let(:ticket_processor) { TicketProcessor.new(Source.new) }
  before { ticket_processor.should_receive(:open).and_return(StringIO.new(fake_source_asset)) }

  describe :process do
    subject { ticket_processor.process }
    it { should == 2 } # return the number of unique parties created

    it "creates the parties as expected" do
      ticket_processor.process
      Party.find_by_name('Party 1').should be_true
      Party.find_by_name('Party 2').should be_true
      Party.find_by_name('Party 3').should_not be_true
    end
  end
end
