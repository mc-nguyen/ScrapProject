require 'fox16'
include Fox

class Book_Info_Window < FXMainWindow
  def initialize(app, title, book)
    super(app, "Book Information", :width => 700, :height => 450)
    # title of book
    titleFrame = FXHorizontalFrame.new(self)
    chrTitle = FXLabel.new(titleFrame, title)
    detailsFrame = FXHorizontalFrame.new(self, :opts => LAYOUT_FILL_X)
    # photo of book + details
    @pic = URI.open(book["img"])
    @pic2 = FXJPGImage.new(app, @pic.read)
    FXImageFrame.new(detailsFrame, @pic2)
    textFrame = FXVerticalFrame.new(detailsFrame, :opts => LAYOUT_FILL)
    rating = FXLabel.new(textFrame, "RATING: " + book["rate"].to_s + "/5 Stars")
    price = FXLabel.new(textFrame, "PRICE: £" + book["price in £"].to_s)
    category = FXLabel.new(textFrame, "CATEGORY: " + book["category"])
    available = FXLabel.new(textFrame, "COPIES AVAILABLE: " + book["available"].to_s)
    descLabel = FXLabel.new(textFrame, "DESCRIPTION:")
    desc = FXText.new(textFrame, :opts => LAYOUT_FILL | TEXT_READONLY | TEXT_WORDWRAP)
    desc.appendText(book["description"])
    upc = FXLabel.new(textFrame, "UPC: " + book["upc"])
  end
  def create
    super
    show(PLACEMENT_SCREEN)
  end
end

#app = FXApp.new
#Book_Info_Window.new(app)
#app.create
#app.run