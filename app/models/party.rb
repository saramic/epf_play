class Party < ActiveRecord::Base
  attr_accessible :name

  validates_presence_of :name
  validates_uniqueness_of :name

  scope :suggest, lambda {|q| where("name ilike ?", "%#{q}%")}

  def to_s
    name
  end
end