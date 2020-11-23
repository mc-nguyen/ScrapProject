require 'nokogiri'
require 'httparty'
require 'byebug'

class Scraper
  def initialize
    @url = "http://books.toscrape.com/"
    @doc = Nokogiri::HTML(HTTParty.get(@url))
    byebug
  end

end

scrap = Scraper.new