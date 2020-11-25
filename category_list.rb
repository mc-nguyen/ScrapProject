require 'nokogiri'
require 'open-uri'
require 'fox16'
include Fox

class CategoryList < FXList
  def initialize(p)
    super(p, :opts => LIST_MULTIPLESELECT|LAYOUT_FIX_X|LAYOUT_FIX_Y|LAYOUT_FIX_WIDTH|LAYOUT_FIX_HEIGHT,
          :x => 20, :y => 20,
          :width => 560, :height => 100)
    collecting
    selecting
  end

  def selecting
    self.connect(SEL_COMMAND) do |sender, sel, index|
      @selected = []
      self.each { |cate| @selected << cate if cate.selected? }
      puts "Selected:"
      @selected.each { |cate| puts "\t#{cate}" }
    end
  end

  def collecting
    url = 'http://books.toscrape.com/'
    html = URI.open(url)&.read
    doc = Nokogiri::HTML(html)
    category = doc.search('ul.nav.nav-list').children[1].children[3].children
    category.each do |x|
      if x.text.strip! != ""
        self.appendItem(x.text.strip!)
      end
    end
  end
end
