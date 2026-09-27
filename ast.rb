require_relative 'translator.rb'
require_relative 'evaluator.rb'

module Ast
    class Integer
        attr_reader :raw_value

        def initialize(raw_value)
            @raw_value = raw_value
        end

        def visit(visitor)
            visitor.visit_type(self)
        end

    end


    class NULL
        attr_reader :raw_value

        def initialize(raw_value)
            @raw_value = raw_value
        end

        def visit(visitor)
            visitor.visit_type(self)
        end
    end

    class Float < Integer
        def visit(visitor)
            visitor.visit_type(self)
        end
    end

    class String
        attr_reader :raw_value

        def initialize(raw_value)
            @raw_value = raw_value
        end

        def visit(visitor)
            visitor.visit_type(self)
        end
    end

    class Boolean
        attr_reader :raw_value

        def initialize(raw_value)
            @raw_value = raw_value
        end

        def visit(visitor)
            visitor.visit_type(self)
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

    class Divide < BinaryOperator
        def visit(visitor)
            visitor.visit_divide(self)
        end
    end

    class Modulo < BinaryOperator
        def visit(visitor)
            visitor.visit_modulo(self)
        end
    end

    class Exponent < BinaryOperator
        def visit(visitor)
            visitor.visit_exponent(self)
        end
    end

    class LogicalNot < Integer
        def visit(visitor)
            visitor.visit_logical_not(self)
        end
    end

    class LogicalAnd < BinaryOperator
        def visit(visitor)
            visitor.visit_logical_and(self)
        end
    end

    class Negate < Integer

        def visit(visitor)
            visitor.visit_negate(self)
        end
    end

    class LogicalOr < BinaryOperator
        def visit(visitor)
            visitor.visit_logical_or(self)
        end
    end

    class BitwiseAnd < BinaryOperator
        def visit(visitor)
            visitor.visit_bitwise_and(self)
        end
    end

    class BitwiseOr < BinaryOperator
        def visit(visitor)
            visitor.visit_bitwise_or(self)
        end
    end

    class BitwiseXor < BinaryOperator
        def visit(visitor)
            visitor.visit_bitwise_xor(self)
        end
    end

    class LeftShift < BinaryOperator
        def visit(visitor)
            visitor.visit_left_shift(self)
        end
    end

    class RightShift < BinaryOperator
        def visit(visitor)
            visitor.visit_right_shift(self)
        end
    end

    class BitwiseNot < Integer
        def visit(visitor)
            visitor.visit_bitwise_not(self)
        end
    end

    class CastFloat < Integer
        def visit(visitor)
            visitor.visit_cast_float(self)
        end
    end

    class CastInteger < Integer
        def visit(visitor)
            visitor.visit_cast_integer(self)
        end
    end

    class Equals < BinaryOperator
        def visit(visitor)
            visitor.visit_equals(self)
        end
    end

    class NotEquals < BinaryOperator
        def visit(visitor)
            visitor.visit_not_equals(self)
        end
    end

    class LessThan < BinaryOperator
        def visit(visitor)
            visitor.visit_less_than(self)
        end
    end

    class LessThanEqual < BinaryOperator
        def visit(visitor)
            visitor.visit_less_than_equals(self)
        end
    end

    class GreaterThan < BinaryOperator
        def visit(visitor)
            visitor.visit_greater_than(self)
        end
    end

    class GreaterThanEqual < BinaryOperator
        def visit(visitor)
            visitor.visit_greater_than_equals(self)
        end
    end

end
