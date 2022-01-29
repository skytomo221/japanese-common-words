require 'nokogiri'
require 'zlib'

dictionary = []
File.open('/JMdict.gz') do |f|
  gz = Zlib::GzipReader.new(f)
  xml = Nokogiri::XML(gz.read)
  item_nodes = xml.xpath('/JMdict/entry')
  item_nodes.each do |element|
    r_ele = element.xpath('r_ele')
    dictionary.append(r_ele.xpath('reb').first) unless r_ele.xpath('re_pri').length.zero?
  end
end
File.open('reb.tsv', 'w') do |f|
  f.write(dictionary.join("\n"))
end
