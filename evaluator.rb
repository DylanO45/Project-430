require_relative 'ast.rb'

class Evaluator
  def visit_integer(node)
    node
  end

  def visit_add(node)
    left_primitive = node.left_node.visit(self)
    right_primitive = node.right_node.visit(self)
    
    if left_primitive.is_a?(Ast::Integer) && right_primitive.is_a?(Ast::Integer)
      Ast::Integer.new(left_primitive.raw_value + right_primitive.raw_value)
    end
  end

  def visit_subtract(node)
    left_primitive = node.left_node.visit(self)
    right_primitive = node.right_node.visit(self)

    if left_primitive.is_a?(Ast::Integer) && right_primitive.is_a?(Ast::Integer)
      difference = left_primitive.raw_value - right_primitive.raw_value
      Ast::Integer.new(difference)
    end
  end


  def visit_multiply(node)
    left_primitive = node.left_node.visit(self)
    right_primitive = node.right_node.visit(self)

    if left_primitive.is_a?(Ast::Integer) && right_primitive.is_a?(Ast::Integer)
      product = left_primitive.raw_value * right_primitive.raw_value
      Ast::Integer.new(product)
    end
  end

  def visit_divide(node)
    left_primitive = node.left_node.visit(self)
    right_primitive = node.right_node.visit(self)
  
    if left_primitive.is_a?(Ast::Integer) && right_primitive.is_a?(Ast::Integer)
      quotient = left_primitive.raw_value / right_primitive.raw_value
      Ast::Integer.new(quotient)
    end
  end

  def visit_modulo(node)
    left_primitive = node.left_node.visit(self)
    right_primitive = node.right_node.visit(self)
  
    if left_primitive.is_a?(Ast::Integer) && right_primitive.is_a?(Ast::Integer)
      remainder = left_primitive.raw_value % right_primitive.raw_value
      Ast::Integer.new(remainder)
    end
  end

  def visit_exponent(node)
    left_primitive = node.left_node.visit(self)
    right_primitive = node.right_node.visit(self)
  
    if left_primitive.is_a?(Ast::Integer) && right_primitive.is_a?(Ast::Integer)
      power = left_primitive.raw_value ** right_primitive.raw_value
      Ast::Integer.new(power)
    end
  end

  def visit_negate(node)
    primitive = node.raw_value.visit(self)
    
    if primitive.is_a?(Ast::Integer)
      negation = -1 * primitive.raw_value
      Ast::Integer.new(negation)
    end
  end


  def visit_logical_not(node)
    left_primitive = node.left_node.visit(self)
    right_primitive = node.right_node.visit(self)
  
    # Integer case
    if left_primitive.is_a?(Ast::Integer) && right_primitive.is_a?(Ast::Integer)
      logical_not = left_primitive.raw_value != right_primitive.raw_value
      Ast::Integer.new(logical_not)
    # Boolean case
    elsif left_primitive.is_a?(Ast::Boolean) && right_primitive.is_a?(Ast::Boolean)
      logical_not = left_primitive.raw_value != right_primitive.raw_value
      Ast::Integer.new(logical_not)
    end
  end

  def visit_logical_and(node)
    left_primitive = node.left_node.visit(self)
    right_primitive = node.right_node.visit(self)
  
    # Integer case
    if left_primitive.is_a?(Ast::Integer) && right_primitive.is_a?(Ast::Integer)
      logical_and = left_primitive.raw_value && right_primitive.raw_value
      Ast::Integer.new(logical_and)
    # Boolean case
    elsif left_primitive.is_a?(Ast::Boolean) && right_primitive.is_a?(Ast::Boolean)
      logical_and = left_primitive.raw_value && right_primitive.raw_value
      Ast::Integer.new(logical_and)
    end
  end

end

