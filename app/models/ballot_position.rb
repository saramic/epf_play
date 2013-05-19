class BallotPosition < ActiveRecord::Base
  attr_accessible :ticket, :position, :candidate
  belongs_to :ticket
  belongs_to :candidate
  has_many :ordinal_preferences
end