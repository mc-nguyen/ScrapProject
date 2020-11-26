require 'fox16'
include Fox

class PriceRange < FXGroupBox
  def initialize(p, y)
    super(
        p, "Price Range",
        :opts => GROUPBOX_TITLE_CENTER | LAYOUT_FILL_X | FRAME_RIDGE | LAYOUT_FIX_Y,
        :y => y)
    elements
  end

  def elements
    FXLabel.new(self, "Min = ", :opts => LAYOUT_EXPLICIT, :x => 20, :y => 20, :width => 50, :height => 30)
    min = FXTextField.new(self, 20,
                          :opts => TEXTFIELD_ENTER_ONLY | TEXTFIELD_INTEGER | LAYOUT_EXPLICIT,
                          :x => 50, :y => 20, :height => 30, :width => 200)
    min.connect(SEL_COMMAND) do
      @min = min.text.to_i
      puts @min
    end
    FXLabel.new(self, "Max = ", :opts => LAYOUT_EXPLICIT, :x => 320, :y => 20, :width => 50, :height => 30)
    max = FXTextField.new(self, 20, :opts => TEXTFIELD_ENTER_ONLY | TEXTFIELD_INTEGER | LAYOUT_EXPLICIT,
                          :x => 350, :y => 20, :height => 30, :width => 200)
    max.connect(SEL_COMMAND) do
      @max = max.text.to_i
      puts @max
    end
  end

  def get_range
    {
        "min" => @min,
        "max" => @max
    }
  end
end
