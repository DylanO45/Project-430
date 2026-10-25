require_relative './lexer.rb'

class Parser
  def initialize(tokens)
    @tokens = tokens
    @i = 0
  end

  def has(type)
    @tokens[@i][:type] == type
  end

  def advance
    @i += 1
    @tokens[@i - 1]
  end+

  def parse
    # builds an AST

    levelN
  end

  def levelN
    if has(:integer)
      left_token = advance
      if has(:slash)
        Ast::Fraction.new(...)
      else
        Ast::Integer.new(...)
    else
      raise "expected integer" # could point to line and column
    end
  end
end


source = "1/2+2/4"
lexer = Lexer.new(source)
tokens = lexer.lex
parser = Parser.new(tokens)
ast = parser.parse


# one level at a time for parser
