require_relative '../instruction'
class XchInstruction < Instruction
  def initialize(args, interpreter)
    super("XCH", args, interpreter)
  end

  def execute
    interpreter.xch
  end
end
