require 'fox16'
require_relative 'scraper'  # needed to be able to grab from book_list
require 'open-uri'
include Fox

class Book_Info_Window < FXMainWindow
  def initialize(app, title, book)
    super(app, "Book Information", :width => 800, :height => 450)
    elements = InfoLayout.new(self, title, book)
  end
  def create
    super
    show(PLACEMENT_SCREEN)
  end
end

class InfoLayout < FXGroupBox

  def initialize(p, title, book)
    super(
        p, title,
        :opts => GROUPBOX_TITLE_CENTER | LAYOUT_FILL_X | FRAME_RIDGE | LAYOUT_FIX_Y)
    elements(book)
  end
  def elements(book)
    detailsFrame = FXHorizontalFrame.new(self, :opts => LAYOUT_FILL_X)
    # photo of book + details
    @pic = URI.open(book["img"])
    @pic2 = FXJPGImage.new(app, @pic.read)
    @pic2.scale(290, 400, 1)
    FXImageFrame.new(detailsFrame, @pic2)
    textFrame = FXVerticalFrame.new(detailsFrame, :opts => LAYOUT_FILL)
    rating = FXLabel.new(textFrame, "RATING: " + book["rate"].to_s + "/5 Stars")
    price = FXLabel.new(textFrame, "PRICE: £" + book["price in £"].to_s)
    category = FXLabel.new(textFrame, "CATEGORY: " + book["category"])
    available = FXLabel.new(textFrame, "COPIES AVAILABLE: " + book["available"].to_s)
    link = FXLabel.new(textFrame, "LINK: " + book["link"])
    descLabel = FXLabel.new(textFrame, "DESCRIPTION:")
    desc = FXText.new(textFrame, :opts => LAYOUT_FILL | TEXT_READONLY | TEXT_WORDWRAP)
    desc.appendText(book["description"])
    upc = FXLabel.new(textFrame, "UPC: " + book["upc"])
  end
end

# just testing the class
scraper = Scraper.new
app = FXApp.new
# book_title = "History of Beauty"
book_title = "Avatar: The Last Airbender: Smoke and Shadow, Part 3 (Smoke and Shadow #3)"
Book_Info_Window.new(app, book_title, scraper.get_book(book_title))
app.create
app.run