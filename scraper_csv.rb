require 'fox16'
require 'csv'
include Fox

class ScraperCSV < FXGroupBox
  def initialize(parent, books, categories)
    super(parent, "", opts: LAYOUT_EXPLICIT, x: 610, y: 450, width: 590, height: 150)
    scraping = FXButton.new(self, "http://books.toscrape.com to CSV file",
                            opts: BUTTON_NORMAL | LAYOUT_CENTER_X | LAYOUT_CENTER_Y | LAYOUT_FIX_WIDTH | LAYOUT_FIX_HEIGHT,
                            height: 30, width: 300)
    scraping.connect(SEL_COMMAND) do
      output(books, categories)
    end
  end

  def output(books, categories)
    CSV.open("scraping.csv", "w") do |csv|
      categories.each do |category|
        csv << [category]
        books.each do |book, info|
          if info['category'] == category
            book_line = ["", book]
            info.each do |c, i|
              if c != "category" then book_line << i end
            end
            csv << book_line
          end
        end
        csv << [""]
      end
    end
  end
end