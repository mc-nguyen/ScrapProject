require 'fox16'
require_relative 'category_list'
require_relative 'PriceRange'
require_relative 'content_include'
require_relative 'submission'
include Fox

class FilterSearch < FXGroupBox
  def initialize(parent)
    super(parent, "Filter Options", :opts => LAYOUT_FILL_X | FRAME_RIDGE)
    @list = CategoryList.new(self, 20)
    @box = PriceRange.new(self, 170)
    @content = ContentInclude.new(self, 250)
    @submission = Submission.new(self, 250)
  end
end