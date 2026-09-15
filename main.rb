require_relative 'ast.rb'
require_relative 'translator.rb'
require_relative 'evaluator.rb'

y = Ast::Integer.new(2)
z = Ast::Integer.new(5)
x = Ast::Add.new(y, z)

# five = Ast::Integer.new(5)

# three_nums = Ast::Add.new(Ast::Add.new(five, five), five)

# translator = Translator.new
# puts three_nums.visit(translator)
# puts three_nums.visit(Evaluator.new).visit(translator)

one = Ast::Integer.new(1)
five = Ast::Integer.new(5)
ten = Ast::Integer.new(10)
three = Ast::Integer.new(3)
neg_hundred = Ast::Integer.new(-100)

#diff = Ast::Subtract.new(Ast::Add.new(five, one), ten)
#product = Ast::Multiply.new(five, ten)
#quotient = Ast::Divide.new(ten, five)
#remainder = Ast::Modulo.new(ten, three)
#power = Ast::Exponent.new(ten, three)
negation = Ast::Negate.new(ten)
negation2 = Ast::Negate.new(neg_hundred)

translator = Translator.new

# puts negation.visit(translator)
# puts negation.visit(Evaluator.new).visit(translator)

# puts negation2.visit(translator)
# puts negation2.visit(Evaluator.new).visit(translator)

#not_equal = Ast::NotEqual.new(ten, ten)
#puts not_equal.visit(translator)
#puts not_equal.visit(Evaluator.new).visit(translator)


bool_true = Ast::Boolean(true)
bool_false = Ast::Boolean(false)

logical_and = Ast::LogicalAnd.new(bool_true, bool_false)
puts logical_and.visit(translator)
puts logical_and.visit(Evaluator.new).visit(translator)