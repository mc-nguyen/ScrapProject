require 'httparty'
require 'nokogiri'
require 'byebug'

def scraper
  url = "http://books.toscrape.com/"
  unparsedPage = HTTParty.get(url)
  parsedPage = Nokogiri::HTML(unparsedPage)
  byebug
end

scraper()
byebug