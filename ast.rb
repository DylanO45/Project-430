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

    class Float < Integer
        def visit(visitor)
            visitor.visit_type(self)
        end
    end
    
    class Boolean
        attr_reader :raw_boolean

        def initialize(raw_boolean)
            @raw_boolean = raw_boolean
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
    
    class LogicalNot < BinaryOperator
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
end