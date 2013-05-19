class Ticket < ActiveRecord::Base
  attr_accessible :ballot, :position
  belongs_to :ballot
  has_many :ballot_positions
end