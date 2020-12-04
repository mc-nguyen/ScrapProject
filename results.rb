require 'fox16'
require_relative 'scraper'
require 'open-uri'
include Fox

class Results < FXMatrix
  def initialize(parent, result)
    super(parent,
          opts: LAYOUT_FILL_X | LAYOUT_FIX_Y | LAYOUT_FIX_HEIGHT | FRAME_NORMAL,
          y: 350, height: 250)
    @library = Scraper.new
    @library = @library.library
  end
end
