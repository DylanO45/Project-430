require_relative 'ast.rb'

class Lexer
  def initialize(source)
    @source = source
    @i = 0
    @tokens = []
    @text_so_far = ''
  end

  def has(c)
    # no need for if statement because just trying to produce a boolean
    @i < @source.length && @source[@i] == c
  end

  def has_digit
    # no need for if statement because just trying to produce a boolean
    @i < @source.length && '0' <= @source[@i] && @source[@i] <= '9'
  end


  def capture
    @text_so_far += @source[@i]
    @i += 1
  end

  def emit_token(type)
    @tokens.push({ #hash for now, class in project
      type: type,
      text: @text_so_far
    })
    @text_so_far = ''
  end

  def lex
    while @i < @source.length
      # lex and append one token
        #Multiple character ops
        if has('**')
            capture; capture
            emit_token(:Exponent)
        elsif has('&&')
            capture; capture
            emit_token(:LogicalAnd)
        elsif has('||')
            capture; capture
            emit_token(:LogicalOr)
        elsif has('==')
            capture; capture
            emit_token(:Equals)
        elsif has('!=')
            capture; capture
            emit_token(:NotEquals)
        elsif has('<=')
            capture; capture
            emit_token(:LessThanEqual)
        elsif has('>=')
            capture; capture
            emit_token(:GreaterThanEqual)
        elsif has('<<')
            capture; capture
            emit_token(:LeftShift)
        elsif has('>>')
            capture; capture
            emit_token(:RightShift)
        
        #Arithmetic and Unary ops
        elsif has('+')
            capture
            emit_token(:Add)
        elsif has('-')
            capture
            emit_token(:Subtract)
        elsif has('(-)')
            capture
            capture
            capture
            emit_token(:Negate)
        elsif has('*')
            capture
            emit_token(:Multiply)
        elsif has('/')
            capture
            emit_token(:Divide)
        elsif has('%')
            capture
            emit_token(:Modulo)
        elsif has('!')
            capture
            emit_token(:LogicalNot)
        elsif has('~')
            capture
            emit_token(:BitwiseNot)
        
        #Bitwise and comparison ops
        elsif has('&')
            capture
            emit_token(:BitwiseAnd)
        elsif has('|')
            capture
            emit_token(:BitwiseOr)
        elsif has('^')
            capture
            emit_token(:BitwiseXor)
        elsif has('<')
            capture
            emit_token(:LessThan)
        elsif has('>')
            capture
            emit_token(:GreaterThan)
        
        # Aggregate Functions (MISSING)
        elsif has('sum')
            capture 
            capture
            capture
            emit_token(:Sum)
        elsif has('min')
            capture 
            capture
            capture
           emit_token(:Min)
        elsif has('max')
            capture 
            capture
            capture
            emit_token(:Max)
        elsif has('mean')
            capture 
            capture
            capture
            capture
            emit_token(:Mean)
        end
        elsif has('(')
    @tokens
  end
end

source = "1/2+2/4"
lexer = Lexer.new(source)
tokens = lexer.lex
puts tokens
