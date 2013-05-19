class Ticket < ActiveRecord::Base
  attr_accessible :ballot, :position, :party
  belongs_to :ballot
  belongs_to :party
  has_many :ballot_positions
end