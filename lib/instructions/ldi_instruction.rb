require_relative '../instruction'
class LdiInstruction < Instruction
  def initialize(args, interpreter)
    super("LDI", args, interpreter)
  end

  def execute
    value = args.first.to_i
    interpreter.ldi(value)
  end
end
