require 'nokogiri'
require 'httparty'
require 'byebug'
require 'open-uri'
require 'csv'

class Scraper
  def initialize
    @url = "http://books.toscrape.com/"
    @html = open(@url).read
    @doc = Nokogiri::HTML(@html)
    @total_page = @doc.search("li.current")[0].children[0].text.strip!.split(' ')[3].to_i
    @book_list = []
    @total_page.times do |i|
      url = @url + "catalogue/page-#{i+1}.html"
      html = open(url).read
      doc = Nokogiri::HTML(html)
      doc.search("article.product_pod").each do |ele|
        book = {
            "img" => @url + ele.css("img.thumbnail")[0].attributes["src"].value,
            "rate" => convert(ele.css('p.star-rating')[0].attributes["class"].value.split(' ')[1]),
            "title" => ele.css("h3")[0].children[0].attributes["title"].value,
            "link" => @url + ele.css("h3")[0].children[0].attributes["href"].value,
            "price in £" => ele.css("p.price_color").text.tr('£','').to_f,
            "in stock" => ele.css("p.instock.availability").text.strip! == "In stock"
        }
        @book_list << book
      end
    end
    count = 1
    @book_list.each do |ele|
      puts "Book #{count}:"
      ele.each do |category, value|
        puts "\t#{category}: #{value}"
      end
      count += 1
    end

    byebug
  end

  def convert(wordNumber)
    translate = {
        "One" => 1,
        "Two" => 2,
        "Three" => 3,
        "Four" => 4,
        "Five" => 5
    }
    return translate[wordNumber]
  end

end

scrap = Scraper.new