require_relative 'ast.rb'

class Evaluator

  # Check the type compatibility of arithmetic operands
  def check_arith_ops(left, right) 
    return left.is_a?(Ast::Integer || Ast::Float) && right.is_a?(Ast::Integer || Ast::Float)
  end
  
  # Check the type compatibilty of logical operands
  def check_log_ops(left, right)
    return left.is_a?(Ast::Boolean || Ast::Integer || Ast::Float) # add string
  end
  
  def visit_type(node)
    # For integers, float, and boolean values. This returns the current single value/type
    node
  end

  def visit_add(node)
    left_primitive = node.left_node.visit(self)
    right_primitive = node.right_node.visit(self)

    if check_arith_ops(left_primitive, right_primitive)
      left_primitive.raw_value.class + right_primitive.raw_value.class
    end
    # left_type = left_primitive.class
    # right_type = right_primitive.class

    # if left_primitive.is_a?(Ast::Integer || Ast::Float) && right_primitive.is_a?(Ast::Integer || Ast::Float)
      
    #   left_type.new(left_primitive.raw_value + right_primitive.raw_value)
    # end
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
  
    # Boolean case
    if left_primitive.is_a?(Ast::Boolean) && right_primitive.is_a?(Ast::Boolean)
      logical_and = left_primitive.raw_boolean && right_primitive.raw_boolean
      Ast::Integer.new(logical_and)
    else
      raise "Operands should be booleans"
    end
  end

  def visit_logical_or(node)
    left_primitive = node.left_node.visit(self)
    right_primitive = node.right_node.visit(self)
  
    # Boolean case
    if left_primitive.is_a?(Ast::Boolean) && right_primitive.is_a?(Ast::Boolean)
      logical_or = left_primitive.raw_boolean || right_primitive.raw_boolean
      Ast::Integer.new(logical_or)
    else
      raise "Operands should be booleans"
    end
  end

end

