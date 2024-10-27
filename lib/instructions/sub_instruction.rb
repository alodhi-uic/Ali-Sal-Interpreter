require_relative '../instruction'
class SubInstruction < Instruction
  def initialize(args, interpreter)
    super("SUB", args, interpreter)
  end

  def execute
    interpreter.sub
  end
end
