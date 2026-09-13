require_relative 'ast.rb'

class Evaluator
  def visit_fraction(node)
    node
  end

  def visit_integer(node)
    node
  end

  def visit_multiply(node)
    left_primitive = node.left_node.visit(self)
    right_primitive = node.right_node.visit(self)
    # TODO: can't assume these are fractions

    if left_primitive.is_a?(Ast::Fraction) && right_primitive.is_a?(Ast::Fraction)
      top = left_primitive.top * right_primitive.top
      bottom = left_primitive.bottom * right_primitive.bottom
      Ast::Fraction.new(top, bottom)
      
    elsif left_primitive.is_a?(Ast::Fraction) && right_primitive.is_a?(Ast::Integer)
      top = left_primitive.top * right_primitive.raw_value
      bottom = left_primitive.bottom
      Ast::Fraction.new(top, bottom)
    end

  end

  # Practice
  def visit_add(node)
    left_primitive = node.left_node.visit(self)
    right_primitive = node.right_node.visit(self)
    
    if left_primitive.is_a?(Ast::Integer) && right_primitive.is_a?(Ast::Integer)
      Ast::Integer.new(left_primitive.raw_value + right_primitive.raw_value)
    end
  end
end
