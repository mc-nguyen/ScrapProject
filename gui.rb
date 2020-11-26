require 'fox16'
require_relative 'filter_search'
include Fox

class BookFinder < FXMainWindow
  def initialize(app)
    super(app, "Book Finder", :width => 600, :height => 600)
    elements = FilterSearch.new(self)
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