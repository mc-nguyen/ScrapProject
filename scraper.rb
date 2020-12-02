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
    puts @total_page
    @book_list = {}
    @categories = {}

    collect_categories
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
      @book_list[ele.css('h3')[0].children[0].attributes['title'].value] = {
        'rate' => convert(ele.css('p.star-rating')[0].attributes['class'].value.split(' ')[1]),
        'link' => @url + "catalogue/" + ele.css('h3')[0].children[0].attributes['href'].value,
        'price in £' => ele.css('p.price_color').text.tr('£', '').to_f,
      }
      collect_more_info(title, @book_list[title]['link'])
    end
  end

  def collect_categories
    # categories setup
    category = @doc.search('ul.nav.nav-list').children[1].children[3].children
    category.each do |x|
      @categories[x.text.strip!] = @url + x.children[1].attributes['href'].value if x.text.strip! != ''
    end
    
    @categories
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

  def print_books
    @book_list.each do |title, info|
      puts "#{title}:"
      info.each do |c, i|
        puts "\t#{c} - #{i}"
      end
    end
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
    puts info
  end
end

scraper = Scraper.new
scraper.print_books