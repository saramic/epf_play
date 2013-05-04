require 'spec_helper'

describe Source do
  let(:source) { Source.new }
  it { source.should be_valid }
end
