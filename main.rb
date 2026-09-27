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
result = Ast::Negate.new(neg_hundred)
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

# ================ BITWISE AND ================
puts " Bitwise And (Both ints) ".center(50, "=")
result = Ast::BitwiseAnd.new(five, ten)
puts result.visit(translator)
puts result.visit(evaluator).visit(translator)

puts " Bitwise And (Incompatible types) ".center(50, "=")
begin
  result3 = Ast::BitwiseAnd.new(float1, float2)
  puts result3.visit(translator)
  puts result3.visit(evaluator).visit(translator)
rescue RuntimeError => e
  puts "Error caught: #{e}"
end

puts
puts

# ================ BITWISE OR ================
puts " Bitwise Or (Both ints) ".center(50, "=")
result = Ast::BitwiseOr.new(five, ten)
puts result.visit(translator)
puts result.visit(evaluator).visit(translator)

puts " Bitwise Or (Incompatible types) ".center(50, "=")
result3 = Ast::BitwiseOr.new(string, ten)
begin
  puts result3.visit(translator)
  puts result3.visit(evaluator).visit(translator)
rescue RuntimeError => e
  puts "Error caught: #{e}"
end

puts
puts

# ================ BITWISE XOR ================
puts " Bitwise Xor (Both ints) ".center(50, "=")
result = Ast::BitwiseXor.new(five, ten)
puts result.visit(translator)
puts result.visit(evaluator).visit(translator)

puts " Bitwise Xor (Incompatible types) ".center(50, "=")
result3 = Ast::BitwiseXor.new(bool_true, ten)
begin
  puts result3.visit(translator)
  puts result3.visit(evaluator).visit(translator)
rescue RuntimeError => e
  puts "Error caught: #{e}"
end

puts
puts

# ================ LEFT SHIFT ================
puts " Left Shift (Both ints) ".center(50, "=")
result = Ast::LeftShift.new(five, one)
puts result.visit(translator)
puts result.visit(evaluator).visit(translator)

puts " Left Shift (Negative int) ".center(50, "=")
result2 = Ast::LeftShift.new(neg_hundred, three)
puts result2.visit(translator)
puts result2.visit(evaluator).visit(translator)

puts " Left Shift (Incompatible types) ".center(50, "=")
result3 = Ast::LeftShift.new(float1, ten)
begin
  puts result3.visit(translator)
  puts result3.visit(evaluator).visit(translator)
rescue RuntimeError => e
  puts "Error caught: #{e}"
end

puts
puts

# ================ RIGHT SHIFT ================
puts " Right Shift (Both ints) ".center(50, "=")
result = Ast::RightShift.new(ten, one)
puts result.visit(translator)
puts result.visit(evaluator).visit(translator)

puts " Right Shift (Negative int) ".center(50, "=")
result2 = Ast::RightShift.new(neg_hundred, three)
puts result2.visit(translator)
puts result2.visit(evaluator).visit(translator)

puts " Right Shift (Incompatible types) ".center(50, "=")
result3 = Ast::RightShift.new(ten, bool_false)
begin
  puts result3.visit(translator)
  puts result3.visit(evaluator).visit(translator)
rescue RuntimeError => e
  puts "Error caught: #{e}"
end

puts
puts

# ================ BITWISE NOT ================
puts " Bitwise Not (Positive Int) ".center(50, "=")
result = Ast::BitwiseNot.new(five)
puts result.visit(translator)
puts result.visit(evaluator).visit(translator)

puts " Bitwise Not (Negative Int) ".center(50, "=")
result2 = Ast::BitwiseNot.new(neg_hundred)
puts result2.visit(translator)
puts result2.visit(evaluator).visit(translator)

puts " Bitwise Not (Incompatible type) ".center(50, "=")
begin
  result3 = Ast::BitwiseNot.new(float1)
  puts result3.visit(translator)
  puts result3.visit(evaluator).visit(translator)
rescue RuntimeError => e
  puts "Error caught: #{e}"
end

puts
puts

# ================ EQUALITY ================
puts " Equals (Same ints) ".center(50, "=")
result = Ast::Equals.new(five, five)
puts result.visit(translator)
puts result.visit(evaluator).visit(translator)

puts " Equals (Different ints) ".center(50, "=")
result2 = Ast::Equals.new(five, ten)
puts result2.visit(translator)
puts result2.visit(evaluator).visit(translator)

puts " Equals (Same floats) ".center(50, "=")
result3 = Ast::Equals.new(float1, float1)
puts result3.visit(translator)
puts result3.visit(evaluator).visit(translator)

puts " Equals (Different types) ".center(50, "=")
begin
  result4 = Ast::Equals.new(five, string)
  puts result4.visit(translator)
  puts result4.visit(evaluator).visit(translator)
rescue RuntimeError => e
  puts "Error caught: #{e}"
end

puts " Not Equals (Same ints) ".center(50, "=")
result5 = Ast::NotEquals.new(five, five)
puts result5.visit(translator)
puts result5.visit(evaluator).visit(translator)

puts " Not Equals (Different ints) ".center(50, "=")
result6 = Ast::NotEquals.new(five, ten)
puts result6.visit(translator)
puts result6.visit(evaluator).visit(translator)

puts " Not Equals (Different types) ".center(50, "=")
begin
  result7 = Ast::NotEquals.new(float1, string2)
  puts result7.visit(translator)
  puts result7.visit(evaluator).visit(translator)
rescue RuntimeError => e
  puts "Error caught: #{e}"
end

puts
puts

# ================ COMPARISONS ================
puts " Less Than (Ints - True) ".center(50, "=")
result = Ast::LessThan.new(five, ten)
puts result.visit(translator)
puts result.visit(evaluator).visit(translator)

puts " Less Than (Ints - False) ".center(50, "=")
result2 = Ast::LessThan.new(ten, five)
puts result2.visit(translator)
puts result2.visit(evaluator).visit(translator)

puts " Less Than (Floats) ".center(50, "=")
result3 = Ast::LessThan.new(float1, float2)
puts result3.visit(translator)
puts result3.visit(evaluator).visit(translator)

puts " Less Than Equal (Same Ints) ".center(50, "=")
result4 = Ast::LessThanEqual.new(five, five)
puts result4.visit(translator)
puts result4.visit(evaluator).visit(translator)

puts " Greater Than (Ints - False) ".center(50, "=")
result5 = Ast::GreaterThan.new(five, ten)
puts result5.visit(translator)
puts result5.visit(evaluator).visit(translator)

puts " Greater Than (Ints - True) ".center(50, "=")
result6 = Ast::GreaterThan.new(ten, five)
puts result6.visit(translator)
puts result6.visit(evaluator).visit(translator)

puts " Greater Than Equal (Same Ints) ".center(50, "=")
result7 = Ast::GreaterThanEqual.new(five, five)
puts result7.visit(translator)
puts result7.visit(evaluator).visit(translator)

puts " Comparisons (Incompatible types) ".center(50, "=")
result8 = Ast::LessThan.new(five, bool_true)
begin
  puts result8.visit(translator)
  puts result8.visit(evaluator).visit(translator)
rescue RuntimeError => e
  puts "Error caught: #{e}"
end

puts
puts

# ================ CAST FLOAT ================
puts " Cast Float (From String) ".center(50, "=")
result = Ast::CastFloat.new(string)
begin
  puts result.visit(translator)
  puts result.visit(evaluator).visit(translator)
rescue RuntimeError => e
  puts "Error caught: #{e}"
end

puts " Cast Float (From Int) ".center(50, "=")
result2 = Ast::CastFloat.new(ten)
puts result2.visit(translator)
puts result2.visit(evaluator).visit(translator)

puts " Cast Float (From Bool) ".center(50, "=")
result3 = Ast::CastFloat.new(bool_true)
begin
  puts result3.visit(translator)
  puts result3.visit(evaluator).visit(translator)
rescue RuntimeError => e
  puts "Error caught: #{e}"
end

puts
puts

# ================ CAST INTEGER ================
puts " Cast Integer (From Float) ".center(50, "=")
result = Ast::CastInteger.new(float1)
puts result.visit(translator)
puts result.visit(evaluator).visit(translator)

puts " Cast Integer (From Bool) ".center(50, "=")
result2 = Ast::CastInteger.new(bool_false)
begin
  puts result2.visit(translator)
  puts result2.visit(evaluator).visit(translator)
rescue RuntimeError => e
  puts "Error caught: #{e}"
end

puts " Cast Integer (From String) ".center(50, "=")
result3 = Ast::CastInteger.new(string)
begin
  puts result3.visit(translator)
  puts result3.visit(evaluator).visit(translator)
rescue RuntimeError => e
  puts "Error caught: #{e}"
end

puts
puts
