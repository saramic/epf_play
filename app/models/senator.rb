class Senator < ActiveRecord::Base
  attr_accessible :name, :position, :source_url, :source_img_url
end