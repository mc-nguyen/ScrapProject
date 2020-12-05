require 'fox16'
require_relative 'scraper'  # needed to be able to grab from book_list
require 'open-uri'
include Fox

class InfoLayout < FXGroupBox
  def initialize(p, title, book)
    super(p, title,
        :opts => GROUPBOX_TITLE_CENTER | LAYOUT_EXPLICIT | FRAME_RIDGE,
          x: 610, width: 590, height: 600)

    detailsFrame = FXHorizontalFrame.new(self, :opts => LAYOUT_FILL_X)
    # photo of book + details
    pic = URI.open(book["img"])&.read
    pic2 = FXJPGIcon.new(app, pic)
    pic2.scale(290, 400)
    @image = FXList.new(detailsFrame, opts: LAYOUT_EXPLICIT, width: 300, height: 410)
    @image.appendItem("", pic2)
    textFrame = FXVerticalFrame.new(detailsFrame, :opts => LAYOUT_FILL | LAYOUT_FIX_Y, y: 900)
    @rate = FXLabel.new(textFrame, "RATING: " + book["rate"].to_s + "/5 Stars")
    @price = FXLabel.new(textFrame, "PRICE: £" + book["price in £"].to_s)
    @category = FXLabel.new(textFrame, "CATEGORY: " + book["category"])
    @available = FXLabel.new(textFrame, "COPIES AVAILABLE: " + book["available"].to_s)
    FXLabel.new(textFrame, "DESCRIPTION:")
    @desc = FXText.new(textFrame, :opts => LAYOUT_FILL | TEXT_READONLY | TEXT_WORDWRAP)
    @desc.appendText(book["description"])
    @upc = FXLabel.new(textFrame, "UPC: " + book["upc"])
  end

  def update(title, info)
    pic = URI.open(info["img"])&.read
    pic = FXJPGIcon.new(app, pic)
    pic.scale(290, 400)
    @image.setItemIcon(0, pic)

    @rate.text = "RATING: " + info["rate"].to_s + "/5 Stars"
    @price.text = "PRICE: £" + info["price in £"].to_s
    @category.text = "CATEGORY: " + info["category"]
    @available.text = "COPIES AVAILABLE: " + info["available"].to_s
    @upc.text = "UPC: " + info["upc"]
    @desc.setText(info["description"])
  end
end