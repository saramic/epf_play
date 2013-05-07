require 'spec_helper'

describe PartiesController do
  it "should respond to index" do
    get :index
    response.should be_success
  end

  describe :suggest do
    before { get :suggest }
    subject { assigns(:parties) }
    it { should == [] }
  end
end