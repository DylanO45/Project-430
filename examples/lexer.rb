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
      if has('+')
        capture
        emit_token(:plus)
      elsif has('/')
        capture
        emit_token(:slash)
      elsif has_digit
        while has_digit
          capture
        end
        emit_token(:integer)
      # other tokens...
      end
    end

    @token
  end
end

source = "1/2+2/4"
lexer = Lexer.new(source)
tokens = lexer.lex
puts tokens
