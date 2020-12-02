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
    @max = @min = 0
    FXLabel.new(self, "Min = ", :opts => LAYOUT_EXPLICIT, :x => 20, :y => 20, :width => 50, :height => 30)
    min = FXTextField.new(self, 20,
                          :opts => TEXTFIELD_INTEGER | LAYOUT_EXPLICIT | TEXTFIELD_NORMAL,
                          :x => 70, :y => 20, :height => 30, :width => 180)
    min.connect(SEL_CHANGED) do
      @min = min.text.to_i
    end
    FXLabel.new(self, "Max = ", :opts => LAYOUT_EXPLICIT, :x => 320, :y => 20, :width => 50, :height => 30)
    max = FXTextField.new(self, 20, :opts => TEXTFIELD_INTEGER | LAYOUT_EXPLICIT | TEXTFIELD_NORMAL,
                          :x => 370, :y => 20, :height => 30, :width => 180)
    max.connect(SEL_CHANGED) do
      @max = max.text.to_i
    end
  end

  def get_range
    {
        "min" => @min,
        "max" => @max
    }
  end
end
