# -*- encoding: UTF-8 -*-
$K='u'
require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'pp'
#require 'jcode'
require 'sanitize'

# 詳細画面のサイドナビから各個別商品にリンクしていく。
url_base  = "http://www.fisharrow.co.jp/product/"
url_start = url_base + "best_Crank.html" 

##FishArrow
puts "#START_UOYA#"

#UOYAルアーデータ取得
doc = Nokogiri.HTML(open(url_start).read)
    
    doc.search('td.td_leed').each do |product|
        if product.child != nil && product.child.inner_text[2..100] != nil
            puts "##" + product.child.inner_text[2..100] + "\n"
            #pp puts product.child
            href = product.child.get_attribute('href')
            if href != nil && href != 'new_colors.html' 
                detail_url = url_base + href
        
                puts detail_url
        
                #詳細情報取得
                detail = Nokogiri.HTML(open(detail_url).read)
            
           
                spec =  detail.search('div.SpecFont').inner_text 
                jack =  detail.search('div.jackSpecArea').inner_text
                name =  detail.search('//*[@id="name"]').inner_text
                read =  detail.search('//*[@id="read"]').inner_text
                text =  detail.search('//*[@id="text"]').inner_text

                if spec != nil
                    puts spec.strip.gsub(/\n/, "").gsub(/\s+/, " ")
                end
 
                if jack != nil
                    puts jack.strip.gsub(/\n/, "").gsub(/\s+/, " ")
                end
            
                if name != nil
                    puts name.strip.gsub(/\n/, "").gsub(/\s+/, " ")
                end
                
                if read != nil
                    puts read.strip.gsub(/\n/, "").gsub(/\s+/, " ")
                end
                if text != nil
                    puts text.strip.gsub(/\n/, "").gsub(/\s+/, " ")
                end
                detail.search('div.txtHdl').each do |color|
                    pp color 
                    if color != nil
                        color_text = color.inner_text
                        if color_text != nil
                            puts color_text
                        end
                    end
                end
            end
        end 
     end   


puts "#END_UOYA#"
 
