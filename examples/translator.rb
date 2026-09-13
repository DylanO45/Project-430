require_relative 'ast.rb'
require_relative 'evaluator.rb'

class Translator
  # def visit_fraction(node)
  #     "Rational(#{node.top}, #{node.bottom})"
  # end

  def visit_integer(node)
    node.raw_value.to_s
  end

  # def visit_multiply(node)
  #       "#{@left_node.visit(self)} * #{@right_node.visit(self)}"
  # end

  def visit_add(node)
        "#{node.left_node.visit(self)} + #{node.right_node.visit(self)}"
  end
end
