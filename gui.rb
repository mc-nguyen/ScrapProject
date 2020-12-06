require 'fox16'
require_relative 'filter_search'
require_relative 'results'
require_relative 'book_info_window'
require_relative 'scraper_csv'
include Fox

class BookFinder < FXMainWindow
  def initialize(app)
    super(app, "Book Finder", :width => 1200, :height => 600)
    @elements = FilterSearch.new(self)
    @submission = FXButton.new(self, "Search!", opts: BUTTON_NORMAL | LAYOUT_EXPLICIT,
                               :x => 200, :y => 260, :height => 30, :width => 200)
    @result = Results.new(self, @elements.print)
    @info = InfoLayout.new(self, @result.get_info[0], @result.get_info[1])
    @scraping = ScraperCSV.new(self, @result.get_library, @elements.get_categories)

    @submission.connect(SEL_COMMAND) do
      @result.filtering(@elements.print)
    end
  end

  def create
    super
    show(PLACEMENT_SCREEN)
  end

  def update_info(title, info)
    @info.update(title, info)
  end
end

app = FXApp.new
BookFinder.new(app)
app.create
app.run