require "spec_helper"

describe PartiesController do
  describe "routing" do
    describe "#index" do
      it { get("/parties").should route_to({:controller => "parties", :action => "index"}) }
      it { parties_path.should eql("/parties") }
    end
  end
end