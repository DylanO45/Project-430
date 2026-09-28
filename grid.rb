class Cell
  attr_accessor :source_code, :ast, :value

  def initialize(source_code = "", ast=nil, value=nil)
      @source_code = source_code
      @ast = ast
      @value = value
  end
end

class Grid
  def initialize()
    # 2D Array
    @grid = Array.new(100) { Array.new(100) }
  end

  def set_cell(address, ast)
      col = address.column
      row = address.row

      evaluator = Evaluator.new(self)

      # Find or create a cell at this address
      cell = @grid[col][row] ||= Cell.new(address, ast)
      cell.ast = ast

      # Evaluate the tree and store its model primitive
      cell.value = ast.visit(evaluator)
  end

  def get_value(address)
      col = address.column
      row = address.row

      cell = @grid[col][row]
      return nil unless cell

      # Return the cell's model primitive
      cell.value
  end
end
