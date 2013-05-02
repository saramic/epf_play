require 'spec_helper'

describe Senator do
  let(:senator) { Senator.new }
  it { senator.should be_valid }
end
