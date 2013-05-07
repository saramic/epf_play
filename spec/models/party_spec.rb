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
  end
end