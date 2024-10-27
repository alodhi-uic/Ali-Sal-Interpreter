require_relative '../instruction'
class DecInstruction < Instruction
  def initialize(args, interpreter)
    super("DEC", args, interpreter)
  end

  def execute
    symbol = args.first
    interpreter.dec(symbol)
  end
end
