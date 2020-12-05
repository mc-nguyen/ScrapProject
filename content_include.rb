require 'fox16'
include Fox

class ContentInclude < FXGroupBox
  def initialize(parent, y)
    @word_include = ""
    super(parent, "Word(s) Include: ", opts: LAYOUT_FIX_WIDTH | FRAME_RIDGE | LAYOUT_FIX_Y | LAYOUT_FIX_X,
          y: y, x: 320, width: 275)
    content = FXTextField.new(self, 20,
                             :opts => TEXTFIELD_NORMAL | LAYOUT_EXPLICIT | LAYOUT_CENTER_X,
                              :x => 20, :y => 20, :height => 30, :width => 200)
    content.connect(SEL_CHANGED) do
      @word_include = content.text
    end
  end

  def get_content
    @word_include
  end
end