require "spec_helper"

describe SenatorsController do
  describe "routing" do
    describe "#index" do
      it { get("/senators").should route_to({:controller => "senators", :action => "index"}) }
      it { senators_path.should eql("/senators") }
    end
  end
end