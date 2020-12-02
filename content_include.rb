require 'fox16'
include Fox

class ContentInclude < FXGroupBox
  def initialize(parent, y)
    super(parent, "Word(s) Include: ", opts: LAYOUT_FIX_WIDTH | FRAME_RIDGE | LAYOUT_FIX_Y,
          y: y, width: 300)
    @content = FXTextField.new(self, 20,
                             :opts => TEXTFIELD_NORMAL | LAYOUT_EXPLICIT | LAYOUT_CENTER_X,
                             :x => 50, :y => 20, :height => 30, :width => 200)
    @content.connect(SEL_COMMAND) do
      puts @content.text
    end
  end

  def get_content
    @content.text
  end
end