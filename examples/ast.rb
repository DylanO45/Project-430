require_relative 'translator.rb'
require_relative 'evaluator.rb'

module Ast
    class Fraction
        attr_reader :top, :bottom

    def initialize(top, bottom)
        @top = top
        @bottom = bottom
    end

    def visit(visitor)
        visitor.visit_fraction(self)
    end

    end

    class Integer
        attr_reader :raw_value

        def initialize(raw_value)
            @raw_value = raw_value
        end

        def visit(visitor)
            visitor.visit_integer(self)
        end

    end

    class BinaryOperator
        attr_reader :left_node, :right_node

        def initialize(left_node, right_node)
            @left_node = left_node
            @right_node = right_node
        end
    end

    class Add < BinaryOperator
        def visit(visitor)
            visitor.visit_add(self)
        end
    end

    class Subtract < BinaryOperator
        def visit(visitor)
            visitor.visit_subtract(self)
        end
    end

    class Multiply < BinaryOperator
        def visit(visitor)
            visitor.visit_multiply(self)
        end
    end
end