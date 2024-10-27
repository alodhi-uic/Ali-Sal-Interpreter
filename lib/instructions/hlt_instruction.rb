require_relative '../instruction'
class HltInstruction < Instruction
  def initialize(args, interpreter)
    super("HLT", args, interpreter)
  end

  def execute
    interpreter.hlt
  end
end
