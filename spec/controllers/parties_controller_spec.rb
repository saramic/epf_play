require 'spec_helper'

describe PartiesController do
  it "should respond to index" do
    get :index
    response.should be_success
  end
end