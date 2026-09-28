require_relative 'ast.rb'
require_relative 'evaluator.rb'

class Translator
  #visit_... method turns current node into type String

  def visit_type(node)
    node.raw_value.to_s
  end

  def visit_add(node)
    "(#{node.left_node.visit(self)} + #{node.right_node.visit(self)})"
  end

  def visit_subtract(node)
        "(#{node.left_node.visit(self)} - #{node.right_node.visit(self)})"
  end

  def visit_multiply(node)
        "(#{node.left_node.visit(self)} * #{node.right_node.visit(self)})"
  end

  def visit_divide(node)
        "(#{node.left_node.visit(self)} / #{node.right_node.visit(self)})"
  end

  def visit_modulo(node)
        "(#{node.left_node.visit(self)} % #{node.right_node.visit(self)})"
  end

  def visit_exponent(node)
        "(#{node.left_node.visit(self)} ** #{node.right_node.visit(self)})"
  end

  def visit_negate(node)
       "((-)#{node.raw_value.visit(self)})"
  end

  def visit_logical_not(node)
      "(!#{node.raw_value.visit(self)})"
  end

  def visit_logical_and(node)
      "(#{node.left_node.visit(self)} && #{node.right_node.visit(self)})"
  end

  def visit_logical_or(node)
      "(#{node.left_node.visit(self)} || #{node.right_node.visit(self)})"
  end

  def visit_bitwise_or(node)
      "(#{node.left_node.visit(self)} | #{node.right_node.visit(self)})"
  end

  def visit_bitwise_and(node)
      "(#{node.left_node.visit(self)} & #{node.right_node.visit(self)})"
  end

  def visit_bitwise_xor(node)
      "(#{node.left_node.visit(self)} ^ #{node.right_node.visit(self)})"
  end

  def visit_left_shift(node)
      "(#{node.left_node.visit(self)} << #{node.right_node.visit(self)})"
  end

  def visit_right_shift(node)
      "(#{node.left_node.visit(self)} >> #{node.right_node.visit(self)})"
  end

  def visit_bitwise_not(node)
      "(~#{node.raw_value.visit(self)})"
  end

  def visit_cast_float(node)
      "(float) (#{node.raw_value.visit(self)})"
  end

  def visit_cast_integer(node)
      "(int) (#{node.raw_value.visit(self)})"
  end

  def visit_equals(node)
      "(#{node.left_node.visit(self)} == #{node.right_node.visit(self)})"
  end

  def visit_not_equals(node)
      "(#{node.left_node.visit(self)} != #{node.right_node.visit(self)})"
  end

  def visit_less_than(node)
      "(#{node.left_node.visit(self)} < #{node.right_node.visit(self)})"
  end

  def visit_less_than_equals(node)
      "(#{node.left_node.visit(self)} <= #{node.right_node.visit(self)})"
  end

  def visit_greater_than(node)
      "(#{node.left_node.visit(self)} > #{node.right_node.visit(self)})"
  end

  def visit_greater_than_equals(node)
      "(#{node.left_node.visit(self)} >= #{node.right_node.visit(self)})"
  end

  def visit_cell_lvalue(node)
    "[#{node.column_node.visit(self)}, #{node.row_node.visit(self)}]"
  end

  def visit_cell_rvalue(node)
    "#[#{node.column_node.visit(self)}, #{node.row_node.visit(self)}]"
  end

  def visit_sum(node)
    "sum(#{node.left_node.visit(self)}, #{node.right_node.visit(self)})"
  end

  def visit_min(node)
    "min(#{node.left_node.visit(self)}, #{node.right_node.visit(self)})"
  end

  def visit_max(node)
    "max(#{node.left_node.visit(self)}, #{node.right_node.visit(self)})"
  end

  def visit_mean(node)
    "mean(#{node.left_node.visit(self)}, #{node.right_node.visit(self)})"
  end

end
