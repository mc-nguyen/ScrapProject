require 'nokogiri'
require 'httparty'
require 'byebug'
require 'json'

class Scraper
  def initialize
    @url = "http://books.toscrape.com/"
    @doc = Nokogiri::HTML(HTTParty.get(@url))
    @total_item = @doc.css('strong').children[0].text.to_i
    @book_list = @doc.css('ol.row')

    byebug
  end

end

scrap = Scraper.new