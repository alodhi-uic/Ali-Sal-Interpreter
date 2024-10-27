require_relative '../instruction'
class StrInstruction < Instruction
  def initialize(args, interpreter)
    super("STR", args, interpreter)
  end

  def execute
    symbol = args.first
    interpreter.str(symbol)
  end
end
