class Party < ActiveRecord::Base
  resourcify

  attr_accessible :name, :home_page, :policies, :twitter, :facebook

  validates_presence_of :name
  validates_uniqueness_of :name

  has_many :candidates

  has_many :sources_referrers, as: :referrer
  has_many :sources, through: :sources_referrers, class_name: Source

  scope :representation_in, lambda { |state| joins(:candidates).where('candidates.state_id = ?', state).group('parties.id') }
  scope :suggest, lambda {|q| where("name ilike ?", "%#{q}%")}

  def candidates_for state
    candidates.where state_id: state
  end

  def to_s
    name
  end

  def to_param
    [id, name].join(' ').parameterize
  end
end