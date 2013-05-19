require 'spec_helper'

describe 'Ballot Results'do
  let(:state) { State.find_by_short_name('VIC') }
  let(:election) { Election.create(name: '2010 Federal Election') }
  let(:ballot) { Ballot.create(state: state, election: election) }
  let(:ticket_a) { Ticket.create(ballot: ballot, position: 'A')}
  let(:ticket_b) { Ticket.create(ballot: ballot, position: 'B')}
  let(:ticket_ug) { Ticket.create(ballot: ballot, position: 'UG')} # un-grouped

  let(:ballot_position_a_0) { BallotPosition.create(ticket: ticket_a, position: 0, candidate: FactoryGirl.create(:candidate, state: state)) }
  let(:ballot_position_a_1) { BallotPosition.create(ticket: ticket_a, position: 1, candidate: FactoryGirl.create(:candidate, state: state)) }
  let(:ballot_position_a_2) { BallotPosition.create(ticket: ticket_a, position: 2, candidate: FactoryGirl.create(:candidate, state: state)) }
  let(:ballot_position_b_0) { BallotPosition.create(ticket: ticket_b, position: 0, candidate: FactoryGirl.create(:candidate, state: state)) }
  let(:ballot_position_b_1) { BallotPosition.create(ticket: ticket_b, position: 1, candidate: FactoryGirl.create(:candidate, state: state)) }
  let(:ballot_position_b_2) { BallotPosition.create(ticket: ticket_b, position: 2, candidate: FactoryGirl.create(:candidate, state: state)) }
  let(:ballot_position_ug_1) { BallotPosition.create(ticket: ticket_ug, position: 1, candidate: FactoryGirl.create(:candidate, state: state)) }

  let(:ordinal_preference_a_0) { OrdinalPreference.create(ordinal: 1, votes: 1000, ballot_position: ballot_position_a_0) }
  let(:ordinal_preference_a_1) { OrdinalPreference.create(ordinal: 1, votes: 100, ballot_position: ballot_position_a_1) }
  let(:ordinal_preference_a_2) { OrdinalPreference.create(ordinal: 1, votes: 10, ballot_position: ballot_position_a_2) }
  let(:ordinal_preference_b_0) { OrdinalPreference.create(ordinal: 1, votes: 900, ballot_position: ballot_position_b_0) }
  let(:ordinal_preference_b_1) { OrdinalPreference.create(ordinal: 1, votes: 90, ballot_position: ballot_position_b_1) }
  let(:ordinal_preference_b_2) { OrdinalPreference.create(ordinal: 1, votes: 9, ballot_position: ballot_position_b_2) }
  let(:ordinal_preference_ug_1) { OrdinalPreference.create(ordinal: 1, votes: 33, ballot_position: ballot_position_ug_1) }

  before do
    ordinal_preference_a_0
    ordinal_preference_a_1
    ordinal_preference_a_2
    ordinal_preference_b_0
    ordinal_preference_b_1
    ordinal_preference_b_2
    ordinal_preference_ug_1
  end

  context 'an election has many ballots' do
    subject { election }
    its(:ballots) { should eql([ballot]) }
  end

  context 'a ballot has many tickets' do
    subject { ballot }
    its(:tickets) { should eql([ticket_a, ticket_b, ticket_ug])}
  end

  context 'a ticket has many positions' do
    subject { ticket_a }
    its(:ballot_positions) { should eql([ballot_position_a_0, ballot_position_a_1, ballot_position_a_2])}
  end

  context 'a ballot position can have many ordinal preferences' do
    subject { ballot_position_a_0 }
    its(:ordinal_preferences) { should eql([ordinal_preference_a_0]) }
  end

  context 'process group tickets' do
    # TODO assume first best candidate in a group for the time being
    before { ballot.reduce(1) } # 1 step
    it 'should distribute group votes to first best candidate' do
      ballot_position_a_0.ordinal_preferences.last.votes.should be_nil
      ballot_position_a_1.ordinal_preferences.last.votes.should == 1100
      ballot_position_a_2.ordinal_preferences.last.votes.should == 10
      ballot_position_b_0.ordinal_preferences.last.votes.should be_nil
      ballot_position_b_1.ordinal_preferences.last.votes.should == 990
      ballot_position_b_2.ordinal_preferences.last.votes.should == 9
      ballot_position_ug_1.ordinal_preferences.last.votes.should == 33
    end
  end

  context 'reduce all votes' do
    # TODO assume no quotas, surpluses
    before { ballot.reduce }
    it 'should reduce all votes to highest initial vote' do
      pending 'that reduce loops through till we have a winner'
      ballot_position_a_0.ordinal_preferences.last.votes.should be_nil
      ballot_position_a_1.ordinal_preferences.last.votes.should == 2142
      ballot_position_a_2.ordinal_preferences.last.votes.should be_nil
      ballot_position_b_0.ordinal_preferences.last.votes.should be_nil
      ballot_position_b_1.ordinal_preferences.last.votes.should be_nil
      ballot_position_b_2.ordinal_preferences.last.votes.should be_nil
      ballot_position_ug_1.ordinal_preferences.last.votes.should be_nil
    end
  end
end
