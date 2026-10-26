require_relative './lexer.rb'

class Parser
  def initialize(tokens)
    @tokens = tokens
    @i = 0
  end

  def has(type)
    @i < @tokens.length && @tokens[@i][:type] == type
  end

  def advance
    @i += 1
    @tokens[@i - 1]
  end

  def parse
    node = parse_expression
    # End of file check
    if @i < @tokens.length
      raise "Parse Error: Unexpected trailing tokens starting at index #{@i} (Token: #{@tokens[@i][:text]})"
    end
    node
  end

  def parse_expression
    # builds an AST
    parse_level_0
  end

  def parse_level_0
    left_node = parse_level_1
    while has(:LogicalOr)
      advance
      right_node = parse_level_1
      left_node = Ast::LogicalOr.new(left_node, right_node)
    end
    left_node
  end

  def parse_level_1
    left_node = parse_level_2
    while has(:LogicalAnd)
      advance
      right_node = parse_level_2
      left_node = Ast::LogicalAnd.new(left_node, right_node)
    end
    left_node
  end

  def parse_level_2
    left_node = parse_level_3
    while has(:BitwiseOr)
      advance
      right_node = parse_level_3
      left_node = Ast::BitwiseOr.new(left_node, right_node)
    end
    left_node
  end

  def parse_level_3
    left_node = parse_level_4
    while has(:BitwiseXor)
      advance
      right_node = parse_level_4
      left_node = Ast::BitwiseXor.new(left_node, right_node)
    end
    left_node
  end

  def parse_level_4
    left_node = parse_level_5
    while has(:BitwiseAnd)
      advance
      right_node = parse_level_5
      left_node = Ast::BitwiseAnd.new(left_node, right_node)
    end
    left_node
  end

  def parse_level_5
    left_node = parse_level_6
    while has(:Equals) || has(:NotEquals)
      operator = advance[:type]
      right_node = parse_level_6
      if operator == :Equals
        left_node = Ast::Equals.new(left_node, right_node)
      else
        left_node = Ast::NotEquals.new(left_node, right_node)
      end
    end
    left_node
  end

  def parse_level_6
    left_node = parse_level_7
    while has(:LessThan) || has(:LessThanEqual) || has(:GreaterThan) || has(:GreaterThanEqual)
      operator = advance[:type]
      right_node = parse_level_7
      if operator == :LessThan
        left_node = Ast::LessThan.new(left_node, right_node)
      elsif operator == :LessThanEqual
        left_node = Ast::LessThanEqual.new(left_node, right_node)
      elsif operator == :GreaterThan
        left_node = Ast::GreaterThan.new(left_node, right_node)
      else
        left_node = Ast::GreaterThanEqual.new(left_node, right_node)
      end
    end
    left_node
  end

  def parse_level_7
    left_node = parse_level_8
    while has(:LeftShift) || has(:RightShift)
      operator = advance[:type]
      right_node = parse_level_8
      if operator == :LeftShift
        left_node = Ast::LeftShift.new(left_node, right_node)
      else
        left_node = Ast::RightShift.new(left_node, right_node)
      end
    end
    left_node
  end

  # Use while loop to enforce left-associativity
  def parse_level_8
    left_node = parse_level_9
    while has(:Add) || has(:Subtract)
      operator = advance[:type]
      right_node = parse_level_9
      if operator == :Add
        left_node = Ast::Add.new(left_node, right_node)
      else
        left_node = Ast::Subtract.new(left_node, right_node)
      end
    end
    left_node
  end

  def parse_level_9
    left_node = parse_level_10
    while has(:Multiply) || has(:Divide) || has(:Modulo)
      operator = advance[:type]
      right_node = parse_level_10
      if operator == :Multiply
        left_node = Ast::Multiply.new(left_node, right_node)
      elsif operator == :Divide
        left_node = Ast::Divide.new(left_node, right_node)
      else
        left_node = Ast::Modulo.new(left_node, right_node)
      end
    end
    left_node
  end

  # Right associative
  def parse_level_10
    left_node = parse_level_11
    if has(:Exponent)
      advance
      right_node = parse_level_10 # recursion enforce right associativity
      left_node = Ast::Exponent.new(left_node, right_node)
    end
    left_node
  end

  # Unary prefix operators
  def parse_level_11
    if has(:Negate) || has(:LogicalNot) || has(:BitwiseNot) || has(:CastFloat) || has(:CastInteger)
      operator = advance[:type]
      operand = parse_level_11 # recursion allows for stacking operators
      if operator == :Negate
        left_node = Ast::Negate.new(operand)
      elsif operator == :LogicalNot
        left_node = Ast::LogicalNot.new(operand)
      elsif operator == :BitwiseNot
        left_node = Ast::BitwiseNot.new(operand)
      elsif operator == :CastFloat
        left_node = Ast::CastFloat.new(operand)
      else
        left_node = Ast::CastInteger.new(operand)
      end
    else
      parse_level_12
    end
  end


  def parse_level_12
    if has(:Integer)
      token = advance
      Ast::Integer.new(token[:text].to_i)
    elsif has(:Float)
      token = advance
      Ast::Float.new(token[:text].to_f)
    elsif has(:Boolean)
      token = advance
      Ast::Boolean.new(token[:text] == 'true')
    elsif has(:String)
      token = advance
      Ast::String.new(token[:text])
    elsif has(:Null)
      advance
      Ast::Null.new
    elsif has(:LParenthesis)
      advance # Consume '('
      node = parse_level_0 # Loop back to the very top of the precedence ladder

      if has(:RParenthesis)
        advance # Consume ')'
        node # Return the parsed expression node (parentheses do not get their own AST node)
      else
        raise "Parse Error: Expected closing ')'"
      end
    elsif has(:LBracket)
      parse_lvalue
    elsif has(:Hash)
      parse_rvalue
    elsif has(:Max) || has(:Min) || has(:Mean) || has(:Sum)
      parse_stat_function
    else
      raise "Parse Error: Unexpected token at index #{@i}"
    end
  end


  def parse_lvalue
    advance # Consume the '['
    col_node = parse_expression

    if !has(:Comma)
      raise "Parse Error: Expected ',' in cell reference"
    end
    advance

    row_node = parse_expression

    if !has(:RBracket)
      raise "Parse Error: Expected ']' in cell reference"
    end
    advance # Consume the ']'

    Ast::CellLvalue.new(col_node, row_node)
  end

  def parse_rvalue
    advance # Consume the '#'

    if !has(:LBracket)
      raise "Parse Error: Expected '[' after '#'"
    end
    advance # Consume the '['

    col_node = parse_expression

    if !has(:Comma)
      raise "Parse Error: Expected ',' in cell reference"
    end
    advance # Consume the ','

    row_node = parse_expression

    if !has(:RBracket)
      raise "Parse Error: Expected ']' in cell reference"
    end
    advance # Consume the ']'

    Ast::CellRvalue.new(col_node, row_node)
  end

  def parse_stat_function
    operator = advance[:type]

    if !has(:LParenthesis)
      raise "Parse Error: Expected '(' after statistical function"
    end
    advance # Consume '('

    start_cell = parse_expression

    if !has(:Comma)
      raise "Parse Error: Expected ',' between range arguments"
    end
    advance # Consume ','

    end_cell = parse_expression

    if !has(:RParenthesis)
      raise "Parse Error: Expected ')' after range arguments"
    end
    advance # Consume ')'

    if operator == :Max
      Ast::Max.new(start_cell, end_cell)
    elsif operator == :Min
      Ast::Min.new(start_cell, end_cell)
    elsif operator == :Mean
      Ast::Mean.new(start_cell, end_cell)
    else
      Ast::Sum.new(start_cell, end_cell)
    end
  end
end
# source = "1/2+2/4"
# lexer = Lexer.new(source)
# tokens = lexer.lex
# parser = Parser.new(tokens)
# ast = parser.parse_expression
