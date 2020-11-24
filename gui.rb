require 'fox16'
include Fox

class BookFinder < FXMainWindow
  def initialize(app)
    super(app, "Book Finder", :width => 200, :height => 100)
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