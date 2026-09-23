require_relative 'ast.rb'
require_relative 'translator.rb'
require_relative 'evaluator.rb'



# ======================================================
translator = Translator.new
evaluator = Evaluator.new

# Ints
one = Ast::Integer.new(1)
five = Ast::Integer.new(5)
ten = Ast::Integer.new(10)
three = Ast::Integer.new(3)
neg_hundred = Ast::Integer.new(-100)
# Floats
float1 = Ast::Float.new(2.5)
float2 = Ast::Float.new(3.14)
# Bools
bool_true = Ast::Boolean.new(true)
bool_false = Ast::Boolean.new(false)
# Strings
string = Ast::String.new("Hello")
string2 = Ast::String.new("World")





# result = Ast::LogicalAnd.new(bool_true, bool_false)
# puts result.visit(translator)
# puts result.visit(evaluator).visit(translator)

# result = Ast::LogicalOr.new(bool_true, bool_false)
# puts result.visit(translator)
# puts result.visit(evaluator).visit(translator)

# result = Ast::LogicalNot.new(one)
# puts result.visit(translator)
# puts result.visit(evaluator).visit(translator)







# ================ ADDITION ================
puts " Addition (Both ints) ".center(50, "=")
result = Ast::Add.new(five, ten)
puts result.visit(translator)
puts result.visit(evaluator).visit(translator)

puts " Addition (Both floats) ".center(50, "=")
result2 = Ast::Add.new(float1, float2)
puts result2.visit(translator)
puts result2.visit(evaluator).visit(translator)

puts " Addition (One int, one float) ".center(50, "=")
result3 = Ast::Add.new(ten, float2)
puts result3.visit(translator)
puts result3.visit(evaluator).visit(translator)

puts " Addition (Incompatible types) ".center(50, "=")
result4 = Ast::Add.new(bool_false, bool_true)
begin
  puts result4.visit(translator)
  puts result4.visit(evaluator).visit(translator)
rescue RuntimeError => e
  puts "Error caught: #{e}"
end

puts " Addition (Both strings) ".center(50, "=")
result5 = Ast::Add.new(string, string2)
puts result5.visit(translator)
puts result5.visit(evaluator).visit(translator)

puts
puts

# ================ SUBTRACTION ================
puts " Subtraction (Both ints) ".center(50, "=")
result = Ast::Subtract.new(five, ten)
puts result.visit(translator)
puts result.visit(evaluator).visit(translator)

puts " Subtraction (Both floats) ".center(50, "=")
result2 = Ast::Subtract.new(float1, float2)
puts result2.visit(translator)
puts result2.visit(evaluator).visit(translator)

puts " Subtraction (One int, one float) ".center(50, "=")
result3 = Ast::Subtract.new(ten, float2)
puts result3.visit(translator)
puts result3.visit(evaluator).visit(translator)

puts " Subtraction (Incompatible types) ".center(50, "=")
result4 = Ast::Subtract.new(bool_false, bool_true)
begin
  puts result4.visit(translator)
  puts result4.visit(evaluator).visit(translator)
rescue RuntimeError => e
  puts "Error caught: #{e}"
end

puts
puts

# ================ MULTIPLICATION ================
puts " Multiplication (Both ints) ".center(50, "=")
result = Ast::Multiply.new(five, ten)
puts result.visit(translator)
puts result.visit(evaluator).visit(translator)

puts " Multiplication (Both floats) ".center(50, "=")
result2 = Ast::Multiply.new(float1, float2)
puts result2.visit(translator)
puts result2.visit(evaluator).visit(translator)

puts " Multiplication (One int, one float) ".center(50, "=")
result3 = Ast::Multiply.new(ten, float2)
puts result3.visit(translator)
puts result3.visit(evaluator).visit(translator)

puts " Multiplication (Incompatible types) ".center(50, "=")
result4 = Ast::Multiply.new(bool_false, bool_true)
begin
  puts result4.visit(translator)
  puts result4.visit(evaluator).visit(translator)
rescue RuntimeError => e
  puts "Error caught: #{e}"
end

puts
puts

# ================ DIVISION ================
puts " Division (Both ints) ".center(50, "=")
result = Ast::Divide.new(ten, five)
puts result.visit(translator)
puts result.visit(evaluator).visit(translator)

puts " Division (Both floats) ".center(50, "=")
result2 = Ast::Divide.new(float1, float2)
puts result2.visit(translator)
puts result2.visit(evaluator).visit(translator)

puts " Division (One int, one float) ".center(50, "=")
result3 = Ast::Divide.new(ten, float2)
puts result3.visit(translator)
puts result3.visit(evaluator).visit(translator)

puts " Division (Incompatible types) ".center(50, "=")
result4 = Ast::Divide.new(bool_false, bool_true)
begin
  puts result4.visit(translator)
  puts result4.visit(evaluator).visit(translator)
rescue RuntimeError => e
  puts "Error caught: #{e}"
end

puts
puts

# ================ MODULO ================
puts " Modulo (Both ints) ".center(50, "=")
result = Ast::Modulo.new(ten, three)
puts result.visit(translator)
puts result.visit(evaluator).visit(translator)

puts " Modulo (Both floats) ".center(50, "=")
result2 = Ast::Modulo.new(float1, float2)
puts result2.visit(translator)
puts result2.visit(evaluator).visit(translator)

puts " Modulo (One int, one float) ".center(50, "=")
result3 = Ast::Modulo.new(ten, float2)
puts result3.visit(translator)
puts result3.visit(evaluator).visit(translator)

puts " Modulo (Incompatible types) ".center(50, "=")
result4 = Ast::Modulo.new(bool_false, bool_true)
begin
  puts result4.visit(translator)
  puts result4.visit(evaluator).visit(translator)
rescue RuntimeError => e
  puts "Error caught: #{e}"
end

puts
puts


# ================ EXPONENTIATION ================
puts " Exponent (Both ints) ".center(50, "=")
result = Ast::Exponent.new(ten, five)
puts result.visit(translator)
puts result.visit(evaluator).visit(translator)

puts " Exponent (Both floats) ".center(50, "=")
result2 = Ast::Exponent.new(float1, float2)
puts result2.visit(translator)
puts result2.visit(evaluator).visit(translator)

puts " Exponent (One int, one float) ".center(50, "=")
result3 = Ast::Exponent.new(ten, float2)
puts result3.visit(translator)
puts result3.visit(evaluator).visit(translator)

puts " Exponent (Incompatible types) ".center(50, "=")
result4 = Ast::Exponent.new(bool_false, bool_true)
begin
  puts result4.visit(translator)
  puts result4.visit(evaluator).visit(translator)
rescue RuntimeError => e
  puts "Error caught: #{e}"
end

puts
puts

# ================ NEGATION ================
puts " Negate (Int) ".center(50, "=")
result = Ast::Negate.new(five)
puts result.visit(translator)
puts result.visit(evaluator).visit(translator)

puts " Negate (Float) ".center(50, "=")
result2 = Ast::Negate.new(float1)
puts result2.visit(translator)
puts result2.visit(evaluator).visit(translator)

puts " Negate (Incompatible type) ".center(50, "=")
result3 = Ast::Negate.new(bool_true)
begin
  puts result3.visit(translator)
  puts result3.visit(evaluator).visit(translator)
rescue RuntimeError => e
  puts "Error caught: #{e}"
end

puts
puts

# ================ LOGICAL AND ================
puts " Logical And (Both bools) ".center(50, "=")
result = Ast::LogicalAnd.new(bool_true, bool_false)
puts result.visit(translator)
puts result.visit(evaluator).visit(translator)

puts " Logical And (Both bools) ".center(50, "=")
result = Ast::LogicalAnd.new(bool_true, bool_true)
puts result.visit(translator)
puts result.visit(evaluator).visit(translator)

puts " Logical And (Incompatible types) ".center(50, "=")
result4 = Ast::LogicalAnd.new(ten, bool_true)
begin
  puts result4.visit(translator)
  puts result4.visit(evaluator).visit(translator)
rescue RuntimeError => e
  puts "Error caught: #{e}"
end

puts
puts

# ================ LOGICAL OR ================
puts " Logical Or (Both bools) ".center(50, "=")
result = Ast::LogicalOr.new(bool_true, bool_false)
puts result.visit(translator)
puts result.visit(evaluator).visit(translator)

puts " Logical Or (Both bools) ".center(50, "=")
result = Ast::LogicalOr.new(bool_false, bool_false)
puts result.visit(translator)
puts result.visit(evaluator).visit(translator)

puts " Logical Or (Incompatible types) ".center(50, "=")
result4 = Ast::LogicalOr.new(ten, bool_true)
begin
  puts result4.visit(translator)
  puts result4.visit(evaluator).visit(translator)
rescue RuntimeError => e
  puts "Error caught: #{e}"
end

puts
puts

# ================ LOGICAL NOT ================
puts " Logical Not (True) ".center(50, "=")
result = Ast::LogicalNot.new(bool_true)
puts result.visit(translator)
puts result.visit(evaluator).visit(translator)

puts " Logical Not (False) ".center(50, "=")
result = Ast::LogicalNot.new(bool_false)
puts result.visit(translator)
puts result.visit(evaluator).visit(translator)

puts " Logical Not (Incompatible type) ".center(50, "=")
result4 = Ast::LogicalNot.new(ten)
begin
  puts result4.visit(translator)
  puts result4.visit(evaluator).visit(translator)
rescue RuntimeError => e
  puts "Error caught: #{e}"
end

puts
puts
