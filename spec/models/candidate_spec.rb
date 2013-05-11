require 'spec_helper'

describe Candidate do
  let(:party) { Party.create(name: 'Party 1')}
  let(:candidate) { Candidate.create(given_name: 'John', surname: 'Citizen', party: party, aec_candidate_id: 1)}

  describe :valid do
    subject { candidate }
    it { should be_valid}
  end
end