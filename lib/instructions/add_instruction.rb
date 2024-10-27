require_relative '../instruction'
class AddInstruction < Instruction
  def initialize(args, interpreter)
    super("ADD", args, interpreter)
  end

  def execute
    interpreter.add
  end
end
