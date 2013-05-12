class HomeController < ApplicationController
  def index
    @listables = State.all
  end
end
