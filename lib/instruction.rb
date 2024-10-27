class Instruction
  attr_reader :opcode, :args, :interpreter

  def initialize(opcode, args, interpreter)
    @opcode = opcode
    @args = args
    @interpreter = interpreter
  end

  def execute
    raise NotImplementedError, "Each instruction must implement the `execute` method"
  end
end
