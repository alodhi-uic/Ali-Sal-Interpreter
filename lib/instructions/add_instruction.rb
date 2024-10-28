require_relative '../instruction'
class AddInstruction < Instruction
  def initialize(args, interpreter)
    super("ADD", args, interpreter)
  end

  def execute
    result = interpreter.a + interpreter.b
    if result.between?(ALIInterpreter::MIN_16_BIT, ALIInterpreter::MAX_16_BIT)
      interpreter.a = result
      interpreter.zero_bit = (interpreter.a == 0)
      if interpreter.describe_instruction
        puts describe
      end
    else
      raise "Overflow: result out of 16-bit range."
    end
  end

  private
  def describe
    "Addition performed."
  end
end