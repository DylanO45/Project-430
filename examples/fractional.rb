require_relative 'ast.rb'
require_relative 'translator.rb'
require_relative 'evaluator.rb'

# f = Ast::Fraction.new(1, 2)
# g = Ast::Fraction.new(11)
# h = Ast::Multiply.new(f, g)
# i = Ast::Integer.new(1)


y = Ast::Integer.new(2)
z = Ast::Integer.new(5)
x = Ast::Add.new(y, z)

five = Ast::Integer.new(5)

three_nums = Ast::Add.new(Ast::Add.new(five, five), five)

translator = Translator.new
puts three_nums.visit(translator)
puts three_nums.visit(Evaluator.new).visit(translator)

# puts i.visit
# translator = Translator.new

# puts h.visit(translator)
# puts h.visits(Evaluator.new).visit(translator)
