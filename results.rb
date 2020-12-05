require 'fox16'
require_relative 'scraper'
require 'open-uri'
include Fox

class Results < FXList
  def initialize(parent, condition)
    super(parent,
          opts: LAYOUT_EXPLICIT | FRAME_NORMAL,
          y: 300, width: 600, height: 300)
    library = Scraper.new
    @books = library.library
    @selected = 0
    connect(SEL_COMMAND) do |i|
      numItems.times do |n|
        @selected = n if itemSelected? n
      end
      parent.update_info(getItem(@selected).text, @books[getItem(@selected).text])
    end
    listingAll
  end

  def listingAll
    threads = []
    @books.each do |title, info|
      threads << Thread.new do
        pic = URI.open(info["img"])&.read
        pic = FXJPGIcon.new(app, pic)
        pic.scale(50, 50)
        appendItem(title, pic)
      end
    end
    threads.each(&:join)
  end

  def filtering(condition)
    numItems.times do |n|
      title = getItem(n).text
      category = (condition['categories'].empty?) || (condition['categories'].include? @books[title]['category'])
      price = @books[title]['price in £'] > condition['range']['min'] && @books[title]['price in £'] < condition['range']['max']
      include = (condition['include'].empty?) || (title.include? condition['include'])
      if category && price && include then enableItem(n)
      else disableItem(n)
      end
      deselectItem(n)
    end
  end

  def get_info
    [getItem(@selected).text, @books[getItem(@selected).text]]
  end
end
