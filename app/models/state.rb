class State < ActiveRecord::Base
  attr_accessible :short_name

  # TODO change short_name to abbreviation ab abrev?
  # TODO add shortcuts State.act, State.vic etc through method_missing
  def to_s
    short_name
  end
end