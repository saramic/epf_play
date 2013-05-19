require "spec_helper"

describe AecResultsProcessor do
  let(:fake_source_asset) {
"""2010 Federal Election Senate First Preferences By State By Vote Type
StateAb,Ticket,CandidateID,BallotPosition,CandidateDetails,PartyName,OrdinaryVotes,AbsentVotes,ProvisionalVotes,PrePollVotes,PostalVotes,TotalVotes
ACT,A,22049,0,A Ticket Votes,Australian Labor Party,67959,1084,398,3960,2517,75918
ACT,A,21065,1,\"LUNDY, Kate Alexandra\",Australian Labor Party,14404,228,58,1041,622,16353
ACT,A,21072,2,\"MATHEWS, David\",Australian Labor Party,1191,24,9,87,57,1368
ACT,B,22050,0,B Ticket Votes,Australian Democrats,2178,41,13,186,109,2527
ACT,B,21758,1,\"CHURCHILL, Darren Mark\",Australian Democrats,1068,11,9,81,62,1231
ACT,B,21760,2,\"DAVID, Anthony John\",Australian Democrats,260,8,2,18,11,299
ACT,C,22048,0,C Ticket Votes,The Greens,27942,633,171,1914,936,31596
ACT,C,20838,1,\"HATFIELD DODDS, Lin\",The Greens,17010,291,81,1086,536,19004
"""}
  let(:aec_results_processor) { AecResultsProcessor.new(Source.new) }
  before { aec_results_processor.should_receive(:open).and_return(StringIO.new(fake_source_asset)) }

  describe :process do
    subject { aec_results_processor.process }
    it { should == {parties: 2, candidates: 3} }

    it 'creates ballot result setup as expected' do
      election = Election.first
      puts election.inspect
      election.name.should eql('2010 Federal Election')
      ballot = Ballot.first
      election.ballots.should eql([ballot])
      state = State.find_by_short_name('ACT')
      ballot.state.should eql(state)
      ticket_act_a = Ticket.find_by_position_and_state('A', state)
      ticket_act_b = Ticket.find_by_position_and_state('B', state)
      ticket_act_c = Ticket.find_by_position_and_state('C', state)
      ticket_act_a.party.should eql(Party.find_by_name('Australian Labor Party'))
      ballot.tickets.should eql([ticket_act_a, ticket_act_b, ticket_act_c])
      ballot_position_act_a_0 = BallotPosition.find_by_candidate_id(22049)
      ballot_position_act_a_1 = BallotPosition.find_by_candidate_id(21065)
      ballot_position_act_a_2 = BallotPosition.find_by_candidate_id(21072)
      ticket_act_a.ballot_positions.should eql([ballot_position_act_a_0, ballot_position_act_a_1, ballot_position_act_a_2])
      ordinal_preference = OrdinalPreference.find_by_ballot_position_id(ballot_position_act_a_0)
      ballot_position_act_a_0.ordinal_preferences.should eql([ordinal_preference])
      ordinal_preference.votes.should eql(16353)
    end
  end
end
