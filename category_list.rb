# frozen_string_literal: true

require 'nokogiri'
require 'open-uri'
require 'fox16'
include Fox

class CategoryList < FXGroupBox
  def initialize(p, y)
    super(p, "Choose Category: ", :opts => LAYOUT_FILL_X | FRAME_RIDGE | LAYOUT_FIX_Y,
          :y => y)
    @list = FXList.new(self, opts: LIST_MULTIPLESELECT | LAYOUT_EXPLICIT,
                       x: 40, y: 30, width: 500, height: 100)
    collecting
    selecting
  end

  def selecting
    @list.connect(SEL_COMMAND) do
      @selected = []
      each { |cate| @selected << cate if cate.selected? }
      puts 'Selected:'
    end
  end

  def collecting
    url = 'http://books.toscrape.com/'
    html = URI.open(url)&.read
    doc = Nokogiri::HTML(html)
    category = doc.search('ul.nav.nav-list').children[1].children[3].children
    category.each do |x|
      @list.appendItem(x.text.strip!) if x.text.strip! != ''
    end
  end

  def get_selected_categories
    @selected
  end
end
