require_relative '../instruction'
class LdiInstruction < Instruction
  def initialize(args, interpreter)
    super("LDI", args, interpreter)
  end

  def execute
    value = args.first.to_i
    if value.between?(ALIInterpreter::MIN_16_BIT, ALIInterpreter::MAX_16_BIT)
      interpreter.a = value
      if interpreter.describe_instruction
        puts describe
      end
    else
      raise "Value out of range for 16-bit integer."
    end
  end

  private

  def describe
    "Loaded the integer value #{args.first.to_i} into the accumulator register."
  end
end