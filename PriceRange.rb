require 'fox16'
include Fox

class PriceRange < FXGroupBox
  def initialize(p, y)
    super(
        p, "Price Range",
        :opts => GROUPBOX_TITLE_CENTER | FRAME_RIDGE | LAYOUT_FIX_Y | LAYOUT_FIX_WIDTH,
        :y => y, :width => 300)
    elements
  end

  def elements
    @min = 0.0
    @max = Float::INFINITY
    FXLabel.new(self, "Min = ", :opts => LAYOUT_EXPLICIT, :x => 20, :y => 20, :width => 50, :height => 30)
    min = FXTextField.new(self, 20,:opts => TEXTFIELD_REAL | LAYOUT_EXPLICIT | TEXTFIELD_NORMAL,
                          :x => 70, :y => 20, :height => 30, :width => 60)
    min.connect(SEL_CHANGED) do
      @min = min.text.to_f
    end
    FXLabel.new(self, "Max = ", :opts => LAYOUT_EXPLICIT, :x => 150, :y => 20, :width => 50, :height => 30)
    max = FXTextField.new(self, 20, :opts => TEXTFIELD_REAL | LAYOUT_EXPLICIT | TEXTFIELD_NORMAL,
                          :x => 200, :y => 20, :height => 30, :width => 60)
    max.connect(SEL_CHANGED) do
      @max = max.text.to_f
      if @max == 0 then @max = Float::INFINITY end
    end
  end

  def get_range
    {
        "min" => @min,
        "max" => @max
    }
  end
end
