$K='u'
require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'pp'

puts "#START--IMAKATSU#"
doc = Nokogiri.HTML(open("http://www.imakatsu.co.jp/products/index.html").read)

#ImakatsuサイトはHTML構造がめちゃくちゃなので、解析が難しい。
#カテゴリ名と各個別商品が並列として存在している。
#それぞれのカテゴリをくるむラッパーがtableでその中にtrが並列している。
#カテゴリ名は 高さ16 altが空白でないもので抽出。
#個別商品はカテゴリ名を含むimgタグから3つ親のtableの中のtrのうち、
#aタグ guideクラスのものを抽出する。
doc.search('img').each do |category|
  if category.get_attribute('height')    == "16" && 
     category.get_attribute('alt').strip != ""
      #カテゴリ名取得
      puts "##" + category.get_attribute('alt')
      #カテゴリ要素の次trの次のtr内から個別商品を取得する。
      obj =  category.parent.parent.parent.search('tr')
      obj.search('a.guide').each do |product|
          # 前後空白削除 改行削除 文字列間の複数空白を空白1つに。
          puts "  " + product.inner_text.strip.gsub(/\n/, "").gsub(/\s+/ ," ")

          #詳細画面URLにアクセス
          detail_url = "http://www.imakatsu.co.jp/products/" + product.get_attribute('href')
        
          detail = Nokogiri.HTML(open(detail_url).read)
          detail.search('tr').each do |main_subscription|
              if main_subscription.get_attribute('valign') == 'top'
                  puts main_subscription.search('.px12').inner_text.strip.gsub(/\n/, "").gsub(/\s+/ ," ");
              end
          end
      end
  end
end
puts "#END--IMAKATSU#"
