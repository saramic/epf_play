class Source < ActiveRecord::Base
  attr_accessible :title, :url, :description, :asset
  attr_readonly :url
  #:hash only set by automated process
  #:parent_url only set by automated process
  #has_many processor # TODO?
  #version # TODO uniq with url

  def to_s
    title
  end
end