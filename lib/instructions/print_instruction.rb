require_relative '../instruction'
class PrintInstruction < Instruction
  def initialize(args, interpreter)
    super("PS", args, interpreter)
  end

  def execute
    interpreter.print_state
  end
end
