require 'nokogiri'
require 'open-uri'

class SenatorImporter
  SOURCE = "http://www.aph.gov.au/Senators_and_Members/Senators/Senators_photos"

  def initialize source=SOURCE
    @source = source
  end

  def import
    doc = Nokogiri::HTML.parse(open(@source))
    doc.css('ul.gallery li').each do |li_element|
      Senator.create(
          name:           li_element.css('span.name').text,
          position:       li_element.css('span.position').text,
          source_url:     URI.join(SOURCE, li_element.css('a').attr('href')).to_s,
          source_img_url: URI.join(SOURCE, li_element.css('img').attr('src')).to_s
      )
    end
  end
end