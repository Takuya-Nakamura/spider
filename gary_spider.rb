$K='u'
require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'pp'

##プロダクト個別取得関数
def get_products(doc, url)
    #productListを先に取得
    productList = doc.search('div.productsList')

    i = 0
    doc.search('div.categoryname').each do |category|
        puts  "##" + category.inner_text

        #category毎の商品を取得
        productList[i].search('img').each do |product|
            puts  "  " +  product.get_attribute('alt')
            detail_url = url +  product.parent.get_attribute('href')
            puts detail_url
            sleep 1 
            detail = Nokogiri.HTML(open(detail_url).read)
            #ワーム名取得
            detail.search("div.text_bold").each do |name| 
                puts name.inner_text.strip.gsub(/\s+/, " ")
            end            
            #説明1取得
            detail.search("div.section").each do |section|
                if section.inner_text !=""
                    puts section.inner_text.strip.gsub(/\s+/, " ")
                end
            end
            #説明2取得
            detail.search("div.sectionBorder").each do |subscription|
                puts subscription.inner_text.strip.gsub(/\s+/, " ")
            end
        end
        i += 1
    end
end



url_base  = "http://www.gary-yamamoto.com/products/" 
url_gary  = url_base + "gary/"
url_yabai = url_base + "yabai/"
url_dragon= url_base + "dragon/"
##gary-Yamamoto
puts "#START_Gary#"

#garyルアーデータ取得
doc = Nokogiri.HTML(open(url_gary).read)
get_products(doc, url_gary)

#yabaiブランド取得
doc = Nokogiri.HTML(open(url_yabai).read)
get_products(doc, url_yabai)

#doragonブランド取得
doc = Nokogiri.HTML(open(url_dragon).read)
get_products(doc, url_dragon)

puts "#END_Gary#"
 
