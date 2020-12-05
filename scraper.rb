# frozen_string_literal: true

require 'nokogiri'
require 'open-uri'

# @!group
class Scraper
  def initialize
    @url = 'http://books.toscrape.com/'
    @html = URI.open(@url)&.read
    @doc = Nokogiri::HTML(@html)
    total_books = @doc.search('form.form-horizontal').text.strip!.split(' ')[0].to_i
    books_per_page = @doc.search('form.form-horizontal').text.strip!.split(' ')[-1].to_i
    @total_page = (total_books.to_f / books_per_page).ceil(0)
    @book_list = {}
    collect_books_threading
  end

  def convert(word)
    translate = {
      'One' => 1,
      'Two' => 2,
      'Three' => 3,
      'Four' => 4,
      'Five' => 5
    }
    translate[word]
  end

  def collect_books(url)
    html = URI.open(url)&.read
    doc = Nokogiri::HTML(html)
    doc.search('article.product_pod').each do |ele|
      title = ele.css('h3')[0].children[0].attributes['title'].value
      link = @url + "catalogue/" + ele.css('h3')[0].children[0].attributes['href'].value
      book_html = URI.open(link)&.read
      book_doc = Nokogiri::HTML(book_html)
      info = {
          "category" => book_doc.search("ul.breadcrumb")[0].children[5].text.strip,
          "description" => book_doc.xpath("//p")[3].text,
          "upc" => book_doc.xpath("//tr")[0].children[2].text,
          "available" => book_doc.xpath("//tr")[5].children.text.strip!.split(' ')[-2].gsub("(","").to_i,
          "img" => book_doc.search("div.item.active")[0].children[1].attributes['src'].value.gsub("../../", @url),
          "rate" => convert(ele.css('p.star-rating')[0].attributes['class'].value.split(' ')[1]),
          "link" => link,
          "price in £" => ele.css('p.price_color').text.tr('£', '').to_f,
      }
      @book_list[title] = info
    end
  end

  def collect_books_threading
    current = Time.now
    threads = []
    @total_page.times do |i|
      url = @url + "catalogue/page-#{i + 1}.html"
      threads << Thread.new { collect_books(url) }
    end
    threads.each(&:join)
    current = Time.now - current
    puts "Time execution: #{current}"
  end

  def collect_more_info(title, book_url)
    html = URI.open(book_url)&.read
    doc = Nokogiri::HTML(html)
    info = {
        "category" => doc.search("ul.breadcrumb")[0].children[5].text.strip,
        "description" => doc.xpath("//p")[3].text,
        "upc" => doc.xpath("//tr")[0].children[2].text,
        "available" => doc.xpath("//tr")[5].children.text.strip!.split(' ')[-2].gsub("(","").to_i,
        "img" => doc.search("div.item.active")[0].children[1].attributes['src'].value.gsub("../../", @url)
    }
    info.each do |c, i|
      @book_list[title][c] = i
    end
  end

  def get_book(title)
    @book_list[title]
  end

  def library
    @book_list
  end
end