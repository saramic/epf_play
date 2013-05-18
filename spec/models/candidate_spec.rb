require 'spec_helper'

describe Candidate do
  let(:candidate) { FactoryGirl.create(:candidate, state: State.first) }

  describe :valid do
    subject { candidate }
    it { should be_valid }
  end
end