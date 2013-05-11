class State < ActiveRecord::Base
  attr_accessible :short_name

  def to_s
    short_name
  end
end