class Candidate < ActiveRecord::Base
  attr_accessible :given_name, :surname, :party, :aec_candidate_id

  validates_presence_of :given_name, :surname, :aec_candidate_id
  validates_uniqueness_of :aec_candidate_id

  belongs_to :party

  scope :suggest, lambda {|q| where("given_name ilike ? or surname ilikek ?", ["%#{q}%", "%#{q}%"])}

  def to_s
    [given_name, surname].join(" ")
  end
end