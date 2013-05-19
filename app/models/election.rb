class Election < ActiveRecord::Base
  attr_accessible :name
  has_many :ballots
end