require_relative 'ast.rb'
require_relative 'grid.rb'


class Evaluator
  def initialize(grid = nil)
    @grid = grid
  end
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
    node
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

    # Short circuit if possible
    if left_primitive.instance_of?(Ast::Boolean)
      return Ast::Boolean.new(false) if left_primitive.raw_value == false
    else
      raise "Operands should be booleans"
    end

    # Continue with right op if no short circuit
    right_primitive = node.right_node.visit(self)
    if right_primitive.instance_of?(Ast::Boolean)
      Ast::Boolean.new(right_primitive.raw_value)
    else
      raise "Operands should be booleans"
    end
  end


  def visit_logical_or(node)
    left_primitive = node.left_node.visit(self)

    # Short circuit if possible
    if left_primitive.instance_of?(Ast::Boolean)
      return Ast::Boolean.new(true) if left_primitive.raw_value == true
    else
      raise "Operands should be booleans"
    end

    # Continue with right op if no short circuit
    right_primitive = node.right_node.visit(self)
    if right_primitive.instance_of?(Ast::Boolean)
      Ast::Boolean.new(right_primitive.raw_value)
    else
      raise "Operands should be booleans"
    end
  end

  # BITWISE OPERATIONS ===============================================

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

  # CASTING OPERATIONS ===============================================

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

  # COMPARISON OPERATIONS ===============================================

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

  def visit_cell_lvalue(node)
    column_val = node.column_node.visit(self)
    row_val = node.row_node.visit(self)

    Ast::CellAddress.new(column_val.raw_value, row_val.raw_value)
  end

  def visit_cell_rvalue(node)
    column_val = node.column_node.visit(self)
    row_val = node.row_node.visit(self)

    address = Ast::CellAddress.new(column_val.raw_value, row_val.raw_value)
    @grid.get_value(address)
  end

  def visit_sum(node)
    left_primitive = node.left_node.visit(self)
    right_primitive = node.right_node.visit(self)

    if left_primitive.instance_of?(Ast::CellAddress) && right_primitive.instance_of?(Ast::CellAddress)
      sum = 0

      # Sort to handle ranges specified in either direction (e.g., B2:A1 vs A1:B2)
      cols = [left_primitive.column, right_primitive.column].sort
      rows = [left_primitive.row, right_primitive.row].sort

      (cols[0]..cols[1]).each do |col|
        (rows[0]..rows[1]).each do |row|
          address = Ast::CellAddress.new(col, row)
          value_node = @grid.get_value(address)

          # Skip or handle nil cells gracefully if needed
          next unless value_node

          if value_node.instance_of?(Ast::Integer) || value_node.instance_of?(Ast::Float)
            sum += value_node.raw_value
          else
            raise "Invalid operand(s)"
          end
        end
      end

      # Return the result wrapped in the correct Ast node type
      sum.is_a?(Float) ? Ast::Float.new(sum) : Ast::Integer.new(sum)
    else
      raise "Invalid operand(s)"
    end
  end

  def visit_max(node)
    left_primitive = node.left_node.visit(self) # start cell address
    right_primitive = node.right_node.visit(self) # final cell address

    max_val = nil
    is_float = false

    if (left_primitive.instance_of?(Ast::CellAddress) && right_primitive.instance_of?(Ast::CellAddress))
      # Loop through columns and roww
      (left_primitive.column..right_primitive.column).each do |col|
        (left_primitive.row..right_primitive.row).each do |row|
          address = Ast::CellAddress.new(col, row)
          cell_val = @grid.get_value(address)

          if cell_val
            # If max_val is initialized or cell_val is new max, overwrite max_val
            if max_val == nil || cell_val.raw_value > max_val
              max_val = cell_val.raw_value
              is_float = cell_val.instance_of?(Ast::Float)
            end
          end
        end
      end

      if max_val == nil
        raise "Empty range"
      end

      if is_float
        Ast::Float.new(max_val)
      else
        Ast::Integer.new(max_val)
      end

    else
      raise "Invalid operand(s)"
    end
  end

  def visit_min(node)
    left_primitive = node.left_node.visit(self) # start cell address
    right_primitive = node.right_node.visit(self) # final cell address

    min_val = nil
    is_float = false

    if (left_primitive.instance_of?(Ast::CellAddress) && right_primitive.instance_of?(Ast::CellAddress))
      # Loop through columns and roww
      (left_primitive.column..right_primitive.column).each do |col|
        (left_primitive.row..right_primitive.row).each do |row|
          address = Ast::CellAddress.new(col, row)
          cell_val = @grid.get_value(address)

          if cell_val
            # If min_val is initialized or cell_val is new max, overwrite max_val
            if min_val == nil || cell_val.raw_value < min_val
              min_val = cell_val.raw_value
              is_float = cell_val.instance_of?(Ast::Float)
            end
          end
        end
      end

      if min_val == nil
        raise "Empty range"
      end

      if is_float
        Ast::Float.new(min_val)
      else
        Ast::Integer.new(min_val)
      end

    else
      raise "Invalid operand(s)"
    end
  end

  def visit_mean(node)
    left_primitive = node.left_node.visit(self) # start cell address
    right_primitive = node.right_node.visit(self) # final cell address

    total_sum = 0
    count = 0

    if (left_primitive.instance_of?(Ast::CellAddress) && right_primitive.instance_of?(Ast::CellAddress))
      # Loop through columns and roww
      (left_primitive.column..right_primitive.column).each do |col|
        (left_primitive.row..right_primitive.row).each do |row|
          address = Ast::CellAddress.new(col, row)
          cell_val = @grid.get_value(address)

          if cell_val
            total_sum += cell_val.raw_value
            count += 1
          end
        end
      end

      if count == 0
        raise "Empty range"
      end

      mean = total_sum.to_f / count
      Ast::Float.new(mean)
    else
      raise "Invalid operand(s)"
    end
  end


end
