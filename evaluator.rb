require_relative 'ast.rb'

class Evaluator
  # Check the type compatibility of arithmetic operands
  def check_arith_ops(left, right)
    # if both ints, return :int
    if left.instance_of?(Ast::Integer) && right.instance_of?(Ast::Integer)
      :int
    # if one or more floats, return :float
    elsif left.instance_of?(Ast::Float) || right.instance_of?(Ast::Float)
      :float
    # else, return :incompatible
    else
      :incompatible
    end
  end

  # Check the type compatibility of logical operands
  def check_log_ops(left, right)
    if left.instance_of?(Ast::Boolean) && right.instance_of?(Ast::Boolean)
      true
    else
      false
    end
  end

  # Check the type compatibility of comparison operands
  def check_comp_ops(left, right)
    if left.instance_of?(Ast::String) && right.instance_of?(Ast::String)
      true
    elsif (left.instance_of?(Ast::Integer) || left.instance_of?(Ast::Float)) && (right.instance_of?(Ast::Integer) || right.instance_of?(Ast::Float))
      true
    else
      false
    end
  end



  def visit_type(node)
    # For integers, float, strings, and boolean values. This returns the current single value/type
    if node.raw_value == "NULL"
      nil
    else
      node
    end
  end

  # ARITHMETIC OPERATIONS ===============================================

  def visit_add(node)
    # Get operand primitives
    left_primitive = node.left_node.visit(self)
    right_primitive = node.right_node.visit(self)

    # Find return type based on operands and error if incompatible
    return_type = check_arith_ops(left_primitive, right_primitive)
    if return_type == :incompatible
      # check if both ops are strings
      if left_primitive.instance_of?(Ast::String) && right_primitive.instance_of?(Ast::String)
        return_type =:string
      else
        raise "Invalid operand(s)"
      end
    end

    # Perform calculation
    sum = left_primitive.raw_value + right_primitive.raw_value

    # Return result with proper type
    if return_type == :int
      Ast::Integer.new(sum)
    elsif return_type == :float
      Ast::Float.new(sum)
    elsif return_type == :string
      Ast::String.new(sum)
    else
      raise "Invalid type to be added"
    end
  end

  def visit_subtract(node)
    # Get operand primitives
    left_primitive = node.left_node.visit(self)
    right_primitive = node.right_node.visit(self)

    # Find return type based on operands and error if incompatible
    return_type = check_arith_ops(left_primitive, right_primitive)
    if return_type == :incompatible
      raise "Invalid operand(s)"
    end

    # Perform calculation
    difference = left_primitive.raw_value - right_primitive.raw_value

    # Return result with proper type
    if return_type == :int
      Ast::Integer.new(difference)
    elsif return_type == :float
      Ast::Float.new(difference)
    else
      raise "Invalid type to be subtracted"
    end
  end


  def visit_multiply(node)
    # Get operand primitives
    left_primitive = node.left_node.visit(self)
    right_primitive = node.right_node.visit(self)

    # Find return type based on operands and error if incompatible
    return_type = check_arith_ops(left_primitive, right_primitive)
    if return_type == :incompatible
      raise "Invalid operand(s)"
    end

    # Perform calculation
    product = left_primitive.raw_value * right_primitive.raw_value

    # Return result with proper type
    if return_type == :int
      Ast::Integer.new(product)
    elsif return_type == :float
      Ast::Float.new(product)
    else
      raise "Invaild type to be multiplied"
    end
  end

  def visit_divide(node)
    # Get operand primitives
    left_primitive = node.left_node.visit(self)
    right_primitive = node.right_node.visit(self)

    # Find return type based on operands and error if incompatible
    return_type = check_arith_ops(left_primitive, right_primitive)
    if return_type == :incompatible
      raise "Invalid operand(s)"
    end

    # Perform calculation
    quotient = left_primitive.raw_value / right_primitive.raw_value

    # Return result with proper type
    if return_type == :int
      Ast::Integer.new(quotient)
    elsif return_type == :float
      Ast::Float.new(quotient)
    else
      raise "Invalid type to be divided"
    end
  end

  def visit_modulo(node)
    # Get operand primitives
    left_primitive = node.left_node.visit(self)
    right_primitive = node.right_node.visit(self)

    # Find return type based on operands and error if incompatible
    return_type = check_arith_ops(left_primitive, right_primitive)
    if return_type == :incompatible
      raise "Invalid operand(s)"
    end

    # Perform calculation
    remainder = left_primitive.raw_value % right_primitive.raw_value

    # Return result with proper type
    if return_type == :int
      Ast::Integer.new(remainder)
    elsif return_type == :float
      Ast::Float.new(remainder)
    else
      raise "Invalid type to be modded"
    end
  end

  def visit_exponent(node)
    # Get operand primitives
    left_primitive = node.left_node.visit(self)
    right_primitive = node.right_node.visit(self)

    # Find return type based on operands and error if incompatible
    return_type = check_arith_ops(left_primitive, right_primitive)
    if return_type == :incompatible
      raise "Invalid operand(s)"
    end

    # Perform calculation
    power = left_primitive.raw_value ** right_primitive.raw_value

    # Return result with proper type
    if return_type == :int
      Ast::Integer.new(power)
    elsif return_type == :float
      Ast::Float.new(power)
    else
      raise "Invalid type to be powered"
    end
  end

  def visit_negate(node)
    primitive = node.raw_value.visit(self)

    if primitive.instance_of?(Ast::Integer) || primitive.instance_of?(Ast::Float)
      negation = (-1) * primitive.raw_value
      Ast::Integer.new(negation)
    else
      raise "Invalid operand"
    end
  end

  # LOGICAL OPERATIONS ===============================================

  def visit_logical_not(node)
    primitive = node.raw_value.visit(self)

    if primitive.instance_of?(Ast::Boolean)
      logical_not = !primitive.raw_value
      Ast::Boolean.new(logical_not)
    else
      raise "Operand should be boolean"
    end
  end

  def visit_logical_and(node)
    left_primitive = node.left_node.visit(self)
    right_primitive = node.right_node.visit(self)

    if check_log_ops(left_primitive, right_primitive)
      logical_and = left_primitive.raw_value && right_primitive.raw_value
      Ast::Boolean.new(logical_and)
    else
      raise "Operands should be booleans"
    end
  end


  def visit_logical_or(node)
    left_primitive = node.left_node.visit(self)
    right_primitive = node.right_node.visit(self)

    if check_log_ops(left_primitive, right_primitive)
      logical_or = left_primitive.raw_value || right_primitive.raw_value
      Ast::Boolean.new(logical_or)
    else
      raise "Operands should be booleans"
    end
  end

  def visit_bitwise_or(node)
    left_primitive = node.left_node.visit(self)
    right_primitive = node.right_node.visit(self)

    if left_primitive.instance_of?(Ast::Integer) && right_primitive.instance_of?(Ast::Integer)
      bitwise_or = left_primitive.raw_value | right_primitive.raw_value
      Ast::Integer.new(bitwise_or)
    else
      raise "Operands should be integer"
    end
  end

  def visit_bitwise_and(node)
    left_primitive = node.left_node.visit(self)
    right_primitive = node.right_node.visit(self)

    if left_primitive.instance_of?(Ast::Integer) && right_primitive.instance_of?(Ast::Integer)
      bitwise_and = left_primitive.raw_value & right_primitive.raw_value
      Ast::Integer.new(bitwise_and)
    else
      raise "Operands should be integer"
    end
  end

  def visit_bitwise_xor(node)
    left_primitive = node.left_node.visit(self)
    right_primitive = node.right_node.visit(self)

    if left_primitive.instance_of?(Ast::Integer) && right_primitive.instance_of?(Ast::Integer)
      bitwise_xor = left_primitive.raw_value ^ right_primitive.raw_value
      Ast::Integer.new(bitwise_xor)
    else
      raise "Operands should be integer"
    end
  end

  def visit_left_shift(node)
    left_primitive = node.left_node.visit(self)
    right_primitive = node.right_node.visit(self)

    if left_primitive.instance_of?(Ast::Integer) && right_primitive.instance_of?(Ast::Integer)
      left_shift = left_primitive.raw_value << right_primitive.raw_value
      Ast::Integer.new(left_shift)
    else
      raise "Operands should be integer"
    end
  end

  def visit_right_shift(node)
    left_primitive = node.left_node.visit(self)
    right_primitive = node.right_node.visit(self)

    if left_primitive.instance_of?(Ast::Integer) && right_primitive.instance_of?(Ast::Integer)
      right_shift = left_primitive.raw_value >> right_primitive.raw_value
      Ast::Integer.new(right_shift)
    else
      raise "Operands should be integer"
    end
  end

  def visit_bitwise_not(node)
    primitive = node.raw_value.visit(self)

    if primitive.instance_of?(Ast::Integer)
      bitwise_not = ~primitive.raw_value
      Ast::Integer.new(bitwise_not)
    else
      raise "Operand should be integer"
    end
  end

  def visit_cast_float(node)
    primitive = node.raw_value.visit(self)
    if primitive.instance_of?(Ast::Integer) || primitive.instance_of?(Ast::Float) || primitive.instance_of?(Ast::String)
      new_float = primitive.raw_value.to_f
      Ast::Float.new(new_float)
    else
      raise "Invalid operand"
    end
  end

def visit_cast_integer(node)
    primitive = node.raw_value.visit(self)

    if primitive.instance_of?(Ast::Integer) || primitive.instance_of?(Ast::Float) || primitive.instance_of?(Ast::String)
        new_int = primitive.raw_value.to_i
        Ast::Integer.new(new_int)
    else
      raise "Invalid operand"
    end
  end

  def visit_equals(node)
    left_primitive = node.left_node.visit(self)
    right_primitive = node.right_node.visit(self)

    if check_comp_ops(left_primitive, right_primitive)
      compared = left_primitive.raw_value == right_primitive.raw_value
      Ast::Boolean.new(compared)
    else
      raise "Invalid operand(s)"
    end
  end

  def visit_not_equals(node)
    left_primitive = node.left_node.visit(self)
    right_primitive = node.right_node.visit(self)

    if check_comp_ops(left_primitive, right_primitive)
      compared = left_primitive.raw_value != right_primitive.raw_value
      Ast::Boolean.new(compared)
    else
      raise "Invalid operand(s)"
    end
  end

  def visit_less_than(node)
    left_primitive = node.left_node.visit(self)
    right_primitive = node.right_node.visit(self)

    if check_comp_ops(left_primitive, right_primitive)
      compared = left_primitive.raw_value < right_primitive.raw_value
      Ast::Boolean.new(compared)
    else
      raise "Invalid operand(s)"
    end
  end

  def visit_less_than_equals(node)
    left_primitive = node.left_node.visit(self)
    right_primitive = node.right_node.visit(self)

    if check_comp_ops(left_primitive, right_primitive)
      compared = left_primitive.raw_value <= right_primitive.raw_value
      Ast::Boolean.new(compared)
    else
      raise "Invalid operand(s)"
    end
  end

  def visit_greater_than(node)
    left_primitive = node.left_node.visit(self)
    right_primitive = node.right_node.visit(self)

    if check_comp_ops(left_primitive, right_primitive)
      compared = left_primitive.raw_value > right_primitive.raw_value
      Ast::Boolean.new(compared)
    else
      raise "Invalid operand(s)"
    end
  end

  def visit_greater_than_equals(node)
    left_primitive = node.left_node.visit(self)
    right_primitive = node.right_node.visit(self)

    if check_comp_ops(left_primitive, right_primitive)
      compared = left_primitive.raw_value >= right_primitive.raw_value
      Ast::Boolean.new(compared)
    else
      raise "Invalid operand(s)"
    end
  end

end
