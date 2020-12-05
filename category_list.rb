# frozen_string_literal: true
require 'open-uri'
require 'nokogiri'
require 'fox16'
include Fox

class CategoryList < FXGroupBox
  def initialize(p, y)
    @selected = []
    super(p, "Choose Category: ", :opts => LAYOUT_FILL_X | FRAME_RIDGE | LAYOUT_FIX_Y,
          :y => y)
    @list = FXList.new(self, opts: LIST_MULTIPLESELECT | LAYOUT_EXPLICIT,
                       x: 40, y: 30, width: 500, height: 100)
    collecting
    @list.connect(SEL_COMMAND) do
      @selected = []
      @list.each { |cate| @selected << cate.text if cate.selected? }
    end
  end

  def collecting
    url = 'http://books.toscrape.com/'
    html = URI.open(url)&.read
    doc = Nokogiri::HTML(html)
    categories = []
    doc.search('ul.nav.nav-list').children[1].children[3].children.each do |x|
      if x.text.strip! != '' then categories << x.text.strip! end
    end
    categories.each do |x|
      @list.appendItem(x)
    end
  end

  def get_selected_categories
    return @selected
  end
end
