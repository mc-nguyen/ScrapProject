require 'fox16'
require_relative 'category_list'
require_relative 'PriceRange'
require_relative 'content_include'
include Fox

class FilterSearch < FXGroupBox
  def initialize(parent)
    super(parent, "Filter Options", :opts => LAYOUT_FIX_WIDTH | FRAME_RIDGE, width: 600)
    @list = CategoryList.new(self, 20)
    @box = PriceRange.new(self, 170)
    @content = ContentInclude.new(self, 170)
  end

  def print
    {
        'categories' => @list.get_selected_categories,
        'range' => @box.get_range,
        'include' => @content.get_content
    }
  end
end