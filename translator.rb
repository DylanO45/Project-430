require_relative 'ast.rb'
require_relative 'evaluator.rb'

class Translator
  #visit_... method turns current node into type String

  def visit_integer(node)
    node.raw_value.to_s
  end

  def visit_add(node)
    "#{node.left_node.visit(self)} + #{node.right_node.visit(self)}"
  end

  def visit_subtract(node)
        "#{node.left_node.visit(self)} - #{node.right_node.visit(self)}"
  end
  
  def visit_multiply(node)
        "#{node.left_node.visit(self)} * #{node.right_node.visit(self)}"
  end

  def visit_divide(node)
        "#{node.left_node.visit(self)} / #{node.right_node.visit(self)}"
  end

  def visit_modulo(node)
        "#{node.left_node.visit(self)} % #{node.right_node.visit(self)}"
  end

  def visit_exponent(node)
        "#{node.left_node.visit(self)} ** #{node.right_node.visit(self)}"
  end

  def visit_negate(node)
       "#{node.raw_value.visit(self)}"
  end
  
  def visit_not(node)
      "#{node.left_node.visit(self)} != #{node.right_node.visit(self)}"
  end
  
end
