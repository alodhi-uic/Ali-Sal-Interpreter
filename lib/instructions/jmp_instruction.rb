require_relative '../instruction'
class JmpInstruction < Instruction
  def initialize(args, interpreter)
    super("JMP", args, interpreter)
  end

  def execute
    address = args.first.to_i
    interpreter.jmp(address)
  end
end
