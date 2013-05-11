require 'spec_helper'

describe Party do
  let(:party) { FactoryGirl.create(:party)}
  let(:nsw) { State.find_by_short_name('NSW') }
  let(:candidate) { FactoryGirl.create(:candidate, state: nsw, party: party) }

  describe :valid do
    subject { party }
    it { should be_valid}

    context 'no name' do
      before { party.name = nil }
      it {should_not be_valid}
    end

    context 'same name' do
      it { lambda{ Party.create!(name: party.name) }.should raise_error(ActiveRecord::RecordInvalid, 'Validation failed: Name has already been taken') }
    end
  end

  describe :candidates_for_state do
    let(:state) { nsw }
    subject { party.candidates_for(state) }

    context 'state with candidate' do
      its(:first) { should eql(candidate) }
    end

    context 'state without candidate' do
      let(:state) { State.find_by_short_name('VIC') }
      it { should_not eql([]) }
    end
  end
end