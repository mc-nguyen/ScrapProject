class BookList < FXMatrix
  def initialize(parent, y)
    super(parent, opts: MATRIX_BY_COLUMNS | LAYOUT_EXPLICIT,
          y: 300, width: 600, height: 300, numColumns: 3)
  end
end