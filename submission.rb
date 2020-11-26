require 'fox16'
include Fox

class Submission < FXGroupBox
  def initialize(parent, y)
    super(parent, "", opts: LAYOUT_FIX_WIDTH | LAYOUT_FIX_Y | LAYOUT_FIX_X,
          y: y, x: 300, width: 300)
    @button = FXButton.new(self, "Search!", opts: LAYOUT_EXPLICIT | BUTTON_NORMAL,
                           :x => 50, :y => 20, :height => 30, :width => 200)
  end
end