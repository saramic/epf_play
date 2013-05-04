class Source < ActiveRecord::Base
  attr_accessible :title, :url, :description, :asset
  attr_readonly :url

  mount_uploader :asset, SourceUploader

  validates_uniqueness_of :hash_identifier
  validates_presence_of :url
  #:hash only set by automated process
  #:parent_url only set by automated process
  #has_many processor # TODO?
  #version # TODO uniq with url

  before_validation :store_asset

  def store_asset
    # TODO ultimately this should be a worker/delayedJob/externalSweepJob
    if url
      self.remote_asset_url = url
      self.hash_identifier = Digest::MD5.hexdigest(open(asset.path).read) # TODO how will this work with fog/EC2
    end
  end

  def to_s
    title
  end
end