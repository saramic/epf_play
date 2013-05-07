require 'spec_helper'

describe Party do
  let(:party) { Party.create(name: 'Party 1')}

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
end