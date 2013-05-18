class Source < ActiveRecord::Base
  attr_accessible :title, :url, :description, :asset
  attr_readonly :url

  mount_uploader :asset, SourceUploader

  validates_uniqueness_of :hash_identifier
  validates_presence_of :title, :url
  #:hash only set by automated process
  #:parent_url only set by automated process
  #has_many processor # TODO?
  #version # TODO uniq with url

  has_many :sources_referrers
  before_validation :store_asset, :title_from_url

  def store_asset
    # TODO ultimately this should be a worker/delayedJob/externalSweepJob
    if !url.blank? and new_record? # TODO confirm that only on on creation!!!!
      self.remote_asset_url = url
      self.hash_identifier = Digest::MD5.hexdigest(open(asset.path).read) if asset.path # TODO how will this work with fog/EC2
    end
  end

  def to_s
    title
  end

  private

  def title_from_url
    return if !title.blank? || url.blank?
    title_string = URI.parse(url).path.sub(/^\//, '')
    title_string = URI.parse(url).host if title_string.blank?
    title_string = title_string.gsub('www.','').
        gsub(/.com[^\/]*/, '').
        gsub(/.au[^\/]*/, '').
        gsub(/(.)([A-Z])/,'\1 \2').
        gsub(/[\.\-_\/]/, ' ').
        gsub(/\s+/,' ')

    self.title = title_string.capitalize.strip
  end
end