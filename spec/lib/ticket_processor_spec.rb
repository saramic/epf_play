require "spec_helper"

describe TicketProcessor do
  let(:fake_source_asset) {"""
State,OwnerGroupNm,CandidateID,Surname,GivenNm
NSW,Party 1,1,1EVANS,Rachel
VIC,Party 1,2,ISKANDER,Soubhi
ACT,Party 2,3,HODGES,Robert
"""}
  let(:ticket_processor) { TicketProcessor.new(Source.new) }
  before { ticket_processor.should_receive(:open).and_return(StringIO.new(fake_source_asset)) }

  describe :process do
    subject { ticket_processor.process }
    it { should == {parties: 2, candidates: 3} }

    it "creates the parties as expected" do
      ticket_processor.process
      Party.find_by_name('Party 1').should be_true
      Party.find_by_name('Party 2').should be_true
      Party.find_by_name('Party 3').should_not be_true
    end

    it "creates the candidates as expected" do
      ticket_processor.process
      candidate_1 = Candidate.find_by_given_name('Rachel')
      candidate_1.should be_true
      candidate_1.party.should eql(Party.find_by_name('Party 1'))
      Candidate.find_by_given_name('Soubhi').should be_true
      Candidate.find_by_given_name('Robert').should be_true
    end
  end
end
