class SourcesReferrer < ActiveRecord::Base
  attr_accessible :referrer, :source, :referrer_field_name
  belongs_to :source
  belongs_to :referrer, :polymorphic => true
end
