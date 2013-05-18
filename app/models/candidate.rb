class Candidate < ActiveRecord::Base
  attr_accessible :given_name, :surname, :party, :aec_candidate_id, :state

  validates_presence_of :given_name, :surname, :aec_candidate_id, :party, :state
  validates_uniqueness_of :aec_candidate_id

  belongs_to :party
  belongs_to :state

  scope :suggest, lambda {|q| where("given_name ilike ? or surname ilike ?", "%#{q}%", "%#{q}%")}

  def to_s
    [given_name, surname].join(" ") + " #{state}"
  end
end