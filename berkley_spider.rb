$K='u'
require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'pp'

#現在参照できるのは2011系
URL_BASE = 'http://www.purefishing.jp/products_2011/berkley/'
URL_GULP_ALIBE = URL_BASE + 'gulp_alive/'
URL_GULP_SOLT  = URL_BASE + 'gulp_saltwater/'
URL_GULP_FRESH = URL_BASE + 'gulp_freshwater_series/'
URL_POWER_BAIT = URL_BASE + 'powerbait/'
URL_HAVOC      = URL_BASE + 'havoc'


##プロダクト個別取得関数
def get_products(doc)

    i = 0
    doc.search('dd.doc_text').each do |product|
        product.search('a').each do |link|
            # 商品名
            puts "##" +  link.inner_text 
            # 商品個別ページ
            detail_url=  link.get_attribute('href')
            sleep 1
            detail = Nokogiri.HTML(open(detail_url).read)
            puts detail.at('div.main_info').inner_text.strip.gsub(/\s+/, ' ')
           
        end
    end        
end


##Berkly
puts "#START_BERKLEY#"

#GULP ALIBE 取得
doc = Nokogiri.HTML(open(URL_GULP_ALIBE).read)
get_products(doc)
sleep 1

#GULP SOLT 取得
doc = Nokogiri.HTML(open(URL_GULP_SOLT).read)
get_products(doc)
sleep 1

#GULP FRESH取得
doc = Nokogiri.HTML(open(URL_GULP_FRESH).read)
get_products(doc)
sleep 1
#POWER BAIT取得
doc = Nokogiri.HTML(open(URL_POWER_BAIT).read)
get_products(doc)
sleep 1
#HAVOC取得
doc = Nokogiri.HTML(open(URL_HAVOC).read)
get_products(doc)
sleep 1


puts "#END_BERKLEY#"
 
