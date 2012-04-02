$K='u'
require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'pp'

#現在参照できるのは2011系
URL_BASE  = 'http://www.megabass.co.jp/products/bass-lure/'


##MEGABASS
puts "#START_MEGABASS#"
#インデックス 取得
doc = Nokogiri.HTML(open(URL_BASE).read)

index = doc.at('//*[@id="index"]');
index.search('li').each do |category|
    #カテゴリ名取得
    puts "##" + category.child.inner_text
    category_url = category.child.get_attribute('href')
    
    #カテゴリ毎ページ取得
    category = Nokogiri.HTML(open(category_url).read)
    category.search('p.information').each do |product|
       #他のspiderはこの段階で商品名を取得していたが、
       #物によって、不要な情報が入るので、商品名は詳細ページから取得する。
       detail_url = product.previous_sibling().previous_sibling().get_attribute('href')
       #詳細ページ取得
       detail = Nokogiri.HTML(open(detail_url).read)
       #商品名取得
       detail.search('//*[@id="content"]').each do |title|
           titleArr =  title.inner_text.split('|')
           puts titleArr[1]
       end

       #Length
       specs = detail.search('div.noMainVisualRight')
       specs.search('td').each do |spec|
           puts spec.inner_text
       end
       #Weight
       #price
       #explain

    end

end

puts "#END_MEGABASS#"
 
