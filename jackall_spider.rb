$KCODE = 'u'
require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'pp'

##JYACKALL
puts "#START-JYACKALL#"
doc = Nokogiri.HTML(open("http://www2.jackall.co.jp/bass/product/lure/index.html").read)

doc.search('img').each do |category|
  if category.get_attribute('height') == '52' && category.get_attribute('width') == '374'
      puts category.get_attribute('name')      
      products =  "http://www2.jackall.co.jp/" + category.parent.get_attribute('href')
      pro_doc = Nokogiri.HTML(open(products).read)
          pro_doc.search('img').each do |product|
          if product.get_attribute('height') == '71' &&  product.get_attribute('width') == '100'
               puts "  " + product.get_attribute('alt')
               detail_url = "http://www2.jackall.co.jp/bass/" + product.parent.get_attribute('href')
               puts detail_url
               detail_doc = Nokogiri.HTML(open(detail_url).read)
               #¿¿¿¿¿¿¿
               detail_doc.search('div.maincopy').each do |description|
                  puts description.inner_text
               end
               #¿¿¿¿¿¿
               detail_doc.search('div.stfrm').each do |subdescription|
                  puts subdescription.search('.sttitle').inner_text
                  puts subdescription.search('.stcopy').inner_text
               end
          end
      end
  end
end

