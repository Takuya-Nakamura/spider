$K='u'
require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'pp'

#現在参照できるのは2011系
URL_BASE  = 'http://www.evergreen-fishing.com'
URL_START = URL_BASE + '/freshwater/'

##EverGreen
puts "#START_EverGreen#"
puts URL_START
#GULP ALIBE 取得
doc = Nokogiri.HTML(open(URL_START).read)
 
doc.search('img').each do |img|
    if img.get_attribute('src') == '/img/products/lure.gif'
      
       img.parent.parent.search('img').each do |lure_category| 
            if lure_category.get_attribute('width') == '179' 
                puts  lure_category.get_attribute('alt')
                category_url =  URL_BASE + lure_category.parent.get_attribute('href')
                #カテゴリページ
                category = Nokogiri.HTML(open(category_url).read)
                category.search('dl.detail').each do |product|
                    puts product.child.inner_text.strip.gsub(/\s+/, " ").gsub(/\n/, "")
                   
                    detail_url =  URL_BASE + product.at('a').get_attribute('href')
                    #商品ページ
                    detail = Nokogiri.HTML(open(detail_url).read)
                    #商品説明概要取得
                    detail.search('em.tit').each do |info| 
                        puts  info.next_sibling().next_sibling().inner_text
                    end    
                    # SPEC取得
                    detail.search('table.spec').each do |specs|
                        specs.search('td').each do |spec|
                            puts spec.inner_text.strip
                        end
                    end

                end
                
            end
            #detail_url =  URL_BASE + lure_category.parent.get_attribute('href')  
            #puts detail_url
       end
    end
  
end

puts "#END_EverGreen#"
 
