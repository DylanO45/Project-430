require_relative 'ast.rb'

class Lexer
  def initialize(source)
    @source = source
    @i = 0
    @tokens = []
    @text_so_far = ''
  end

  def has(c)
    @i + c.length <= @source.length && @source[@i, c.length] == c
  end

  #checks what number it is
  def has_digit
    @i < @source.length && '0' <= @source[@i] && @source[@i] <= '9'
  end

  #grab the current value at current index
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
            capture
            capture
            emit_token(:Exponent)
        elsif has('&&')
            capture
            capture
            emit_token(:LogicalAnd)
        elsif has('||')
            capture
            capture
            emit_token(:LogicalOr)
        elsif has('==')
            capture
            capture
            emit_token(:Equals)
        elsif has('!=')
            capture
            capture
            emit_token(:NotEquals)
        elsif has('<=')
            capture
            capture
            emit_token(:LessThanEqual)
        elsif has('>=')
            capture
            capture
            emit_token(:GreaterThanEqual)
        elsif has('<<')
            capture
            capture
            emit_token(:LeftShift)
        elsif has('>>')
            capture
            capture
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

        #casting int and float
        elsif has('(float)')
            7.times {capture}
            emit_token(:CastFloat)
        elsif has('(int)')
            5.times {capture}
            emit_token(:CastInteger)

        # Aggregate Functions
        elsif has("sum")
            3.times {capture}
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

        #Cell Rvalue and Lvalue
        elsif has('#')
            capture
            emit_token(:Hash)
        elsif has('[')
            capture
            emit_token(:LBracket)
        elsif has(']')
            capture
            emit_token(:RBracket)
        elsif has(',')
            capture
            emit_token(:Comma)

        elsif has('(')
            capture
            emit_token(:LParenthesis)
        elsif has(')')
            capture
            emit_token(:RParenthesis)

        #booleans
        elsif has ("true")
            4.times {capture}
            emit_token(:Boolean)
        elsif has ("false")
            5.times {capture}
            emit_token(:Boolean)

        #String
        elsif has('"')
        @i += 1

        while @i < @source.length && !has('"')
          if has('\\"')
            capture
            capture
          else
            capture
          end
        end
        if has('"')
          @i += 1
          emit_token(:String)
        end

        #Integer and float numbers
        elsif has_digit
            while has_digit
                capture
            end
            if has('.')
                capture
                while has_digit
                    capture
                end
                emit_token(:Float)
            else
                emit_token(:Integer)
            end

        #whitespaces and empty
        elsif has(" ")
            @text_so_far = ''
            @i += 1
        else
            raise "Lexer Error: Unrecognized character '#{@source[@i]}' at index #{@i}"
        end
    end

    @tokens
  end
end
