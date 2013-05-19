class OrdinalPreference < ActiveRecord::Base
  attr_accessible :ordinal, :votes, :ballot_position
  belongs_to :ballot_position
end