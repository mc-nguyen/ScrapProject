require 'fox16'
require_relative 'filter_search'
require_relative 'results'
include Fox

class BookFinder < FXMainWindow
  def initialize(app)
    super(app, "Book Finder", :width => 600, :height => 600)
    elements = FilterSearch.new(self)
    @result = Results.new(self, elements.print)
  end

  def create
    super
    show(PLACEMENT_SCREEN)
  end
end

app = FXApp.new
BookFinder.new(app)
app.create
app.run